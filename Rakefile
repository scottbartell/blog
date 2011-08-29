task :default => :jekyll

desc 'Build Compass output'
task :compass => :'compass:clean' do
  system 'compass compile --config config/compass.rb'
end

namespace :compass do
  desc 'Clean Compass output'
  task :clean do
    system 'rm -rf jekyll/stylesheets/*'
  end
  
  desc 'Start Compass watching the SASS directory'
  task :watch => :'compass:clean' do
    system 'compass watch --config config/compass.rb'
  end
end

desc 'Start local server'
task :server do
  system 'foreman start'
end

desc 'Clean and rebuild the Jekyll site'
task :jekyll => [:compass, :'jekyll:clean'] do
  system 'jekyll jekyll jekyll/_site --no-auto'
end

namespace :jekyll do
  desc 'Clean Jekyll site'
  task :clean do
    system 'rm -rf jekyll/_site'
  end

  desc 'Clean site and start watching'
  task :watch => [:compass, :'jekyll:clean'] do
    system 'jekyll jekyll jekyll/_site --auto'
  end
end
