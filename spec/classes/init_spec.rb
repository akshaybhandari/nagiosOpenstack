require 'spec_helper'
describe 'nagiosopenstack' do

  context 'with defaults for all parameters' do
    it { should contain_class('nagiosopenstack') }
  end
end
