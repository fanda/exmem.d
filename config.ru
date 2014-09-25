require 'sprockets'
require 'rack'
require 'rack/mount'

project_root = File.expand_path(File.dirname(__FILE__))
Assets = Sprockets::Environment.new(File.dirname(__FILE__))

Assets.append_path(File.join(project_root, 'assets'))
Assets.append_path(File.join(project_root, 'assets', 'javascripts'))
Assets.append_path(File.join(project_root, 'assets', 'stylesheets'))

Routes = Rack::Mount::RouteSet.new do |set|
  set.add_route Assets, :path_info => %r{^/assets}

  map "/assets" do
    run Assets
  end
end

run Routes
