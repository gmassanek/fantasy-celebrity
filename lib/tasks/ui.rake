desc "Build the ember UI and copy necessary files to /public"
namespace :ui do
  task :build do
    original_dir = FileUtils.pwd

    begin
      FileUtils.cd("fantasy-celebrity-front-end")
      system("npm install")
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
end
