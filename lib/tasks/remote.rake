# rails deploy:run でデプロイ処理を実行

# rubocop:disable Metrics/BlockLength
namespace :remote do
  def target_env
    ENV.fetch('TARGET_ENV', 'production')
  end

  def docker_options
    [
      "-f #{work_dir}/docker-compose-#{target_env}.yml"
    ].join(' ')
  end

  def branch
    ENV.fetch('BRANCH', ENV.fetch('branch', 'main'))
  end

  def host
    ENV.fetch("SSH_#{target_env.upcase}_HOST")
  end

  def work_dir
    "/var/www/#{ENV.fetch('APP_NAME')}"
  end

  def global_env_file
    Rails.root.join('.env')
  end

  def env_file
    Rails.root.join(".env.#{target_env}")
  end

  def run_ssh_command(command, tty: false)
    tty_option = tty ? ' -t' : ''

    sh %(ssh#{tty_option} #{host} "#{command}")
  end

  desc 'Run deploy'
  task deploy: :environment do
    Rake::Task['remote:env:update'].invoke
    Rake::Task['remote:git:update'].invoke
    Rake::Task['remote:docker:run'].invoke
  end

  desc 'Follow docker container log output'
  task log: :environment do
    command = "docker compose #{docker_options} logs -f"

    run_ssh_command(command, tty: true)
  end

  %i[web app db].each do |service|
    service_map = { web: 'Nginx', app: 'Rails', db: 'PostgreSQL' }

    namespace service do
      desc "Run ash script in #{service_map[service]} container"
      task ash: :environment do
        command = "docker exec -it #{service} ash"

        run_ssh_command(command, tty: true)
      end

      desc "Follow #{service_map[service]} container log output"
      task log: :environment do
        command = "docker logs -f #{service}"

        run_ssh_command(command, tty: true)
      end
    end
  end

  namespace :app do
    desc 'Run Rails console'
    task console: :environment do
      command = "docker compose #{docker_options} run --rm app bin/rails console"

      run_ssh_command(command, tty: true)
    end
  end

  namespace :web do
    desc 'Nginx conf test'
    task test_conf: :environment do
      command = "docker compose #{docker_options} run --rm web nginx -t"

      run_ssh_command(command)
    end

    desc 'Reload Nginx'
    task reload: :environment do
      command = 'docker exec web nginx -s reload'

      run_ssh_command(command)
    end
  end

  namespace :db do
    %i[create migrate prepare rollback seed seed_fu].each do |action|
      desc "#{action.capitalize} database"
      task action => :environment do
        command = "docker compose #{docker_options} run --rm app bin/rails db:#{action}"

        run_ssh_command(command)
      end
    end

    desc 'reset and migrate database'
    task reset: :environment do
      check_value = ENV.fetch('DISABLE_DATABASE_ENVIRONMENT_CHECK', nil)
      if check_value.nil?
        raise 'If you are sure you want to continue,
               run the same command with the environment variable: DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
      end

      command = "docker compose #{docker_options} run --rm app
                 bin/rails db:migrate:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=#{check_value}"

      run_ssh_command(command)
    end

    desc 'login to PostgreSQL'
    task psql: :environment do
      target_env_data = Dotenv.parse(env_file)
      database = target_env_data['POSTGRES_DB']
      user = target_env_data['POSTGRES_USER']
      command = "docker exec -it db psql #{database} -U #{user}"

      run_ssh_command(command, tty: true)
    end
  end

  namespace :docker do
    desc 'Up docker compose'
    task run: :environment do
      command = "docker compose #{docker_options} up --build -d"

      run_ssh_command(command)
    end

    desc 'Prune docker system'
    task prune: :environment do
      command = 'docker system prune -f'

      run_ssh_command(command)
    end

    %i[build stop down].each do |action|
      desc "#{action.capitalize} docker compose"
      task action => :environment do
        command = "docker compose #{docker_options} #{action}"

        run_ssh_command(command)
      end
    end
  end

  namespace :git do
    desc 'Update remote code'
    task update: :environment do
      command = [
        "cd #{work_dir}",
        "git fetch --prune origin #{branch}",
        "git reset --hard origin/#{branch}"
      ].join('; ')

      run_ssh_command(command)
    end

    desc 'Display git logs'
    task log: :environment do
      command = [
        "cd #{work_dir}",
        'git log --oneline'
      ].join('; ')

      run_ssh_command(command)
    end
  end

  namespace :env do
    task update: :environment do
      remote_path = "#{host}:#{work_dir}"

      sh "scp #{global_env_file} #{remote_path}" if File.exist?(global_env_file)
      sh "scp #{env_file} #{remote_path}" if File.exist?(env_file)
    end
  end
end
# rubocop:enable Metrics/BlockLength
