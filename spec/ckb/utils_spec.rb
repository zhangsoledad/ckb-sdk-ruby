RSpec.describe CKB::Utils do
  Utils = CKB::Utils

  let(:privkey) { "0xe79f3207ea4980b7fed79956d5934249ceac4751a4fae01a0f7c4a96884bc4e3" }
  let(:pubkey) { "0x024a501efd328e062c8675f2365970728c859c592beeefd6be8ead3d901330bc01" }
  let(:address) { "0xbc374983430db3686ab181138bb510cb8f83aa136d833ac18fc3e73a3ad54b8b" }
  let(:privkey_bin) { Utils.hex_to_bin(privkey) }
  let(:pubkey_bin) { Utils.hex_to_bin(pubkey) }
  let(:pubkey_hash) { "0x36c329ed630d6ce750712a477543672adab57f4c6fd36a71496305456bb298db" }
  let(:pubkey_hash_bin) { Utils.hex_to_bin(pubkey_hash) }
  let(:prefix) { "ckt" }
  let(:address) { "ckt1qqqqqqqqqgmvx20dvvxkee6swy4ywa2rvu4d4dtlf3hax6n3f93s23ttk2vdk68gmaq" }

  context "address" do
    it "pubkey_hash_bin" do
      expect(
        Utils.pubkey_hash_bin(pubkey_bin)
      ).to eq pubkey_hash_bin
    end

    it "generate_address" do
      generated_address = Utils.generate_address(prefix, pubkey_hash_bin)
      expect(generated_address).to eq address
    end

    it "parse_address" do
      expect(
        Utils.parse_address(address, prefix)
      ).to eq pubkey_hash_bin
    end
  end

  def always_success_json_object
    hash_bin = CKB::Blake2b.digest(
      Utils.hex_to_bin(
        "0x1400000000000e00100000000c000800000004000e0000000c00000014000000740100000000000000000600080004000600000004000000580100007f454c460201010000000000000000000200f3000100000078000100000000004000000000000000980000000000000005000000400038000100400003000200010000000500000000000000000000000000010000000000000001000000000082000000000000008200000000000000001000000000000001459308d00573000000002e7368737472746162002e74657874000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000010000000600000000000000780001000000000078000000000000000a000000000000000000000000000000020000000000000000000000000000000100000003000000000000000000000000000000000000008200000000000000110000000000000000000000000000000100000000000000000000000000000000000000"
      )
    )
    always_success_cell_hash = Utils.bin_to_prefix_hex(hash_bin)
    {
      binary_hash: always_success_cell_hash,
      args: []
    }
  end

  let(:always_success_type_hash) { "0x86f4f705a8e85905b1c73b84b1f3a3cf6dbfdd7eb8e47bfd1c489681ee2762cb" }

  it "hex to bin" do
    hex = "abcd12"
    expect(Utils.hex_to_bin(hex)).to eq [hex].pack("H*")
  end

  it "prefix hex to bin" do
    hex = "abcd12"
    prefix_hex = "0x#{hex}"
    expect(Utils.hex_to_bin(prefix_hex)).to eq Utils.hex_to_bin(hex)
  end

  it "bin to hex" do
    hex = "abcd12"
    bin = [hex].pack("H*")
    expect(Utils.bin_to_hex(bin)).to eq hex
  end

  it "bin to prefix hex" do
    hex = "abcd12"
    bin = [hex].pack("H*")
    prefix_hex = "0x#{hex}"
    expect(Utils.bin_to_prefix_hex(bin)).to eq prefix_hex
  end

  it "extract pubkey bin" do
    expect(Utils.extract_pubkey_bin(privkey_bin)).to eq pubkey_bin
  end

  it "json script to type hash" do
    expect(
      Utils.json_script_to_type_hash(always_success_json_object)
    ).to eq always_success_type_hash
  end
end
