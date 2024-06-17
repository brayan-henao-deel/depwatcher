require "spec2"
require "./httpclient_mock"
require "../../src/depwatcher/go"

Spec2.describe Depwatcher::Go do
  let(client) { HTTPClientMock.new }
  subject { described_class.new.tap { |s| s.client = client } }
  before do
    client.stub_get("https://go.dev/dl/", nil, HTTP::Client::Response.new(200, File.read(__DIR__+"/../fixtures/golang.html")))
  end

  describe "#check" do
    it "returns real releases sorted" do
      expect(subject.check.map(&.ref)).to eq [
        "1.2.2", "1.3", "1.3.1", "1.3.2", "1.3.3", "1.4", "1.4.1", "1.4.2",
        "1.4.3", "1.5", "1.5.1", "1.5.2", "1.5.3", "1.5.4", "1.6", "1.6.1",
        "1.6.2", "1.6.3", "1.6.4", "1.7", "1.7.1", "1.7.3", "1.7.4", "1.7.5",
        "1.7.6", "1.8", "1.8.1", "1.8.2", "1.8.3", "1.8.4", "1.8.5", "1.8.6",
        "1.8.7", "1.9", "1.9.1", "1.9.2", "1.9.3", "1.9.4", "1.9.5", "1.9.6",
        "1.9.7", "1.10", "1.10.1", "1.10.2", "1.10.3", "1.10.4", "1.10.5",
        "1.10.6", "1.10.7", "1.10.8", "1.11", "1.11.1", "1.11.2", "1.11.3",
        "1.11.4", "1.11.5", "1.11.6", "1.11.7", "1.11.8", "1.11.9", "1.11.10",
        "1.11.11", "1.11.12", "1.11.13", "1.12", "1.12.1", "1.12.2", "1.12.3",
        "1.12.4", "1.12.5", "1.12.6", "1.12.7", "1.12.8", "1.12.9", "1.12.10",
        "1.12.11", "1.12.12", "1.12.13", "1.12.14", "1.12.15", "1.12.16",
        "1.12.17", "1.13", "1.13.1", "1.13.2", "1.13.3", "1.13.4", "1.13.5",
        "1.13.6", "1.13.7", "1.13.8", "1.13.9", "1.13.10", "1.13.11", "1.13.12",
        "1.13.13", "1.13.14", "1.13.15", "1.14", "1.14.1", "1.14.2", "1.14.3",
        "1.14.4", "1.14.5", "1.14.6", "1.14.7", "1.14.8", "1.14.9", "1.14.10",
        "1.14.11", "1.14.12", "1.14.13", "1.14.14", "1.14.15", "1.15", "1.15.1",
        "1.15.2", "1.15.3", "1.15.4", "1.15.5", "1.15.6", "1.15.7", "1.15.8",
        "1.15.9", "1.15.10", "1.15.11", "1.15.12", "1.15.13", "1.15.14",
        "1.15.15", "1.16", "1.16.1", "1.16.2", "1.16.3", "1.16.4", "1.16.5",
        "1.16.6", "1.16.7", "1.16.8", "1.16.9", "1.16.10", "1.17", "1.17.1",
        "1.17.2", "1.17.3"
      ]
    end
  end

  describe "#in" do
    it "returns real releases sorted" do
      obj = subject.in("1.8.4")
      expect(obj.ref).to eq "1.8.4"
      expect(obj.url).to eq "https://dl.google.com/go/go1.8.4.src.tar.gz"
      expect(obj.sha256).to eq "abf1b2e5ae2a4845f3d2eac00c7382ff209e2c132dc35b7ce753da9b4f52e59f"
    end
  end
end
