require 'spec_helper'

describe GSP::Protocols::Regulations::CFSI::CMRT::Versions do
  let(:versions) do
    c = Class
    c.send(:include, GSP::Protocols::Regulations::CFSI::CMRT::Versions)
    c.new
  end

  it "should detect version 1.00" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_1.00.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '1.00'
  end

  it "should detect version 2.00" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_2.00.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '2.00'
  end

  it "should detect version 2.01" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_2.01.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '2.01'
  end

  it "should detect version 2.02" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_2.02.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '2.02'
  end

  it "should detect version 2.03a" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_2.03a.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '2.03a'
  end

  it "should detect version 3.00" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_3.00.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '3.00'
  end

  it "should detect version 3.01" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_3.01.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_version
    worksheet_0_data = File.read(fp)
    expect(versions.get_version(worksheet_0_data)).to eq '3.01'
  end

  it "should list similarity ratings for string against all worksheet 0 versions" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_2.03a.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_similarity_ratings
    expect(versions.get_similarity_ratings(File.read(fp)).to be_kind_of Array
  end

  it "should list Jaro-Winkler distance ratings for string against all worksheet 0 versions" do
    fp = File.join(File.dirname(__FILE__), 'versions', 'sample_cmrt_2.03a.xlsx.csv.0')
    expect(File.exists?(fp)).to be_true
    expect(versions).to respond_to :get_jarow_distances
    expect(versions.get_jarow_distances(File.read(fp)).to be_kind_of Array
  end
end
