# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path("../config/application", __FILE__)

Rails.application.load_tasks

desc 'build frontend'
task :build_frontend do
  original_dir = FileUtils.pwd

  begin
    FileUtils.cd("fantasy-celebrity-front-end")
    system("npm install")
    system("bower install")
    system("ember build -e production")

    dist_path = "fantasy-celebrity-front-end/dist"
    FileUtils.cd(original_dir)

    FileUtils.cp_r("#{dist_path}/assets", "public/")
    FileUtils.cp_r("#{dist_path}/fonts", "public/")
    FileUtils.cp_r("#{dist_path}/images", "public/")
    FileUtils.cp_r("#{dist_path}/index.html", "public/index.html")
  ensure
    FileUtils.cd(original_dir)
  end

end
