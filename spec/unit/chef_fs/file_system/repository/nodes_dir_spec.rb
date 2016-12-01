require "spec_helper"
require "chef/chef_fs/file_system/repository/chef_repository_file_system_root_dir"
require "chef/chef_fs/file_system/repository/nodes_dir"

describe Chef::ChefFS::FileSystem::Repository::NodesDir do
  let(:tmp_path) { Dir.mktmpdir }
  let(:child_paths) { { "nodes" => [tmp_path] } }
  let(:root_dir) do
    Chef::ChefFS::FileSystem::Repository::ChefRepositoryFileSystemRootDir.new(child_paths)
  end
  let(:nodes_dir) { described_class.new("nodes", root_dir, tmp_path) }
  let(:node_name) { "test-node" }
  let(:node_path) { File.join(nodes_dir.file_path, "#{node_name}.json") }
  let(:node_content) { '{"name": "test-node"}' }

  describe "#create_child" do
    it "creates the file" do
      node_file = nodes_dir.create_child(node_name, node_content)
      expect(node_file.exists?).to be(true)
    end

    it "sets the correct permissions" do
      expect(File).to receive(:chmod).with(0600, node_path)
      nodes_dir.create_child(node_name, node_content)
    end
  end
end
