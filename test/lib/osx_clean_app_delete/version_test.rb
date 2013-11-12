require_relative '../../test_helper'
 
describe OsxCleanAppDelete do
 
  it "must be defined" do
    OsxCleanAppDelete::OsxCleanAppDeleteCli.start(["version"]).wont_be_nil
  end
 
end