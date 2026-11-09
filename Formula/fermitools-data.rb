# typed: strict
# frozen_string_literal: true

# Reference files distributed alongside the Science Tools.
class FermitoolsData < Formula
  desc "Reference data files for the Fermi LAT Science Tools"
  homepage "https://github.com/fermi-lat/fermitools-data"
  url "https://github.com/fermi-lat/fermitools-data.git",
      using:    :git,
      revision: "5345b7e627914a0b36eb321bfd5747cabfd96f48"
  version "0.21"
  license :cannot_represent

  resource "gll_iem_v07" do
    url "https://fermi.gsfc.nasa.gov/ssc/data/analysis/software/aux/4fgl/gll_iem_v07.fits"
    sha256 "2cef0173af218c6aa3d644b5a477eae00b0079d7a11d1a911f897e33fcc56285"
  end

  def install
    refdata = share/"fermitools/refdata/fermi"
    refdata.mkpath
    %w[counterpartCatalogs galdiffuse jplephem pass8Analysis].each do |directory|
      cp_r buildpath/directory, refdata
    end

    resource("gll_iem_v07").stage do
      cp "gll_iem_v07.fits", refdata/"galdiffuse"
    end
  end

  test do
    refdata = share/"fermitools/refdata/fermi"
    %w[counterpartCatalogs galdiffuse jplephem pass8Analysis].each do |directory|
      assert_predicate refdata/directory, :directory?
    end
    assert_predicate refdata/"galdiffuse/gll_iem_v07.fits", :file?
  end
end
