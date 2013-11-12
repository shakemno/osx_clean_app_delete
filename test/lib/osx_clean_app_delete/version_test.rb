require_relative '../../test_helper'
 
describe OsxCleanAppDelete do
 
  it "must be defined" do
    OsxCleanAppDelete::OsxCleanAppDeleteCli.start(["version"]).wont_be_nil
  end
 
  # make test like this...
  # http://guides.rubygems.org/make-your-own-gem/#adding-an-executable
end