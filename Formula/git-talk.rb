
class GitTalk < Formula
  desc "GitTalk"
  homepage "https://github.com/sandeepraju/git-talk"
  url "https://github.com/sandeepraju/git-talk/archive/0.0.8a0.tar.gz"
  version "3"
  sha256 "f2c62dfada11eabc0bc3eddbae1a10ffe0bf9b9da47854aa2600044491c338e2"

  depends_on :python => :recommended if MacOS.version <= :snow_leopard
  depends_on "python" => "with-tcl-tk"
  depends_on "ffmpeg" => :run

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    Language::Python.each_python(build) do |python, version|
      dest_path = lib/"python#{version}/site-packages"
      dest_path.mkpath

      with_environment({"PYTHONPATH" => "#{dest_path}",
                        "PATH" => "#{bin}:#{ENV["PATH"]}"}) do
        system python, "setup.py", "install", "--prefix=#{prefix}"
      end      
    end
  end

  def with_environment(h)
    old = Hash[h.keys.map { |k| [k, ENV[k]] }]
    ENV.update h
    begin
      yield
    ensure
      ENV.update old
    end
  end

  test do
    system "false"
  end
end
