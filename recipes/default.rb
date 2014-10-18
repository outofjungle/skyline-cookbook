
apt_repository 'wheezy-backports' do
  uri 'http://http.debian.net/debian wheezy-backports'
  components ['main']
end

apt_preference 'redis-server' do
  pin 'version 2.8.17-1'
  pin_priority '900'
end

packages = %w(git python-dev python-pip python-numpy python-scipy python-scikits.statsmodels redis-server)

packages.each do | pkg |
  package pkg
end

python_pacakges = {
  'redis' => '2.7.2',
  'hiredis' => '0.1.1',
  'python-daemon' => '1.6',
  'flask' => '0.9',
  'simplejson' => '2.0.9',
  'unittest2' => nil,
  'mock' => nil,
  'patsy' => nil,
  'msgpack_python' => nil
}

python_pacakges.each do | package_name, package_version |
  python_pip package_name do
    version package_version unless package_version.nil?
    action :install
  end
end

directories = [
  '/var/log/skyline',
  '/var/run/skyline',
  '/var/log/redis',
  '/var/dump',
  '/opt/etsy'
]

directories.each do |dir|
  directory dir do
    owner 'vagrant'
    group 'vagrant'
    recursive true
  end
end

git '/opt/etsy/skyline' do
  repository 'https://github.com/etsy/skyline.git'
  revision 'master'
  action :sync
  user 'vagrant'
  group 'vagrant'
end
