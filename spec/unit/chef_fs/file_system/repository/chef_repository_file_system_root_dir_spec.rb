require "spec_helper"
require "chef/chef_fs/file_system/repository/chef_repository_file_system_root_dir"

describe Chef::ChefFS::FileSystem::Repository::ChefRepositoryFileSystemRootDir do
  let(:tmp_path) { Dir.mktmpdir }
  let(:nodes_path) { File.join(tmp_path, "nodes") }
  let(:child_paths) { { "nodes" => [nodes_path] } }
  let(:root_dir) { described_class.new(child_paths) }

  describe "#create_child" do
    context "when creating the nodes directory" do
      it "creates the directory" do
        nodes_dir = root_dir.create_child("nodes")
        expect(nodes_dir.exists?).to be(true)
      end

      it "sets the correct permissions" do
        expect(File).to receive(:chmod).with(0700, nodes_path)
        root_dir.create_child("nodes")
      end
    end
  end
end
