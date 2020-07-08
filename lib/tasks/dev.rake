namespace :dev do
  DEFAULT_PASSWORD = 123456

  desc "TODO"
  task setup: :environment do
    if Rails.env.development?
      set_setup_task('Dropping database') { %x(rails db:drop) }
      set_setup_task('Creating database') {%x(rails db:create) }
      set_setup_task('Migrating database') { %x(rails db:migrate) }
      set_setup_task('Creating default admin') { %x(rails dev:add_default_admin) }
      set_setup_task('Creating default user') { %x(rails dev:add_default_user) }
    else
      puts 'Task can only be used on development environment'
    end
  end

  desc 'Adiciona o administrador padrão'
    task add_default_admin: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Adiciona o usuário padrão'
    task add_default_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
  end

  private
    def set_setup_task(message)
      spinner = TTY::Spinner.new("[:spinner] #{message}")
      spinner.auto_spin
      yield
      spinner.success('... Done!')
    end
end
