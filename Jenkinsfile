node('master') {

  stage 'Checkout'
  git url: 'https://github.com/k2works/baukis-kai.git'

  stage 'Prepare'
  env.PATH = '/usr/local/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH'
  sh 'eval "$(rbenv init -)"'
  sh 'rbenv local 2.4.0'

  stage 'Prepare test'
  sh "bundle install"
  sh "bundle exec rake db:migrate"
  sh "bundle exec rake db:test:prepare"

  stage "Unit test"
  sh "bundle exec rspec spec/controllers/*_spec.rb"
  sh "bundle exec rspec spec/models/*_spec.rb"
  sh "bundle exec rspec spec/routing/*_spec.rb"
  sh "bundle exec rspec spec/services/*_spec.rb"

  stage "Integration test"
  sh "bundle exec rspec spec/features/*_spec.rb"
}
