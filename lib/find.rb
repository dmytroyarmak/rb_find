require "etc"

class Find

  def initialize dir, options = {} 
    raise ArgumentError, 'First argument must be a directory, or a symlink that points at a directory.' unless File.directory?(dir)
    @dir = dir
    if options[:maxdepth]
      @files = []
      add_files_from_dir( dir, options[:maxdepth] )
    else
      @files = Dir.glob(File.join(dir, "**", "*"))
    end
    self.type options[:type] if options[:type]
    self.name options[:name] if options[:name]
    self.uname options[:uname] if options[:uname]
    self.cnewer options[:cnewer] if options[:cnewer]
    self
  end

  # Predicate matches if browsed file is of desired type
  # t = "file" | "directory" | "link" | "socket" | ..
  def type t
    @files = @files.select { |file| File.exist?(file) && File.ftype(file) == t}
    self
  end
  
  # Predicate matches if browsed file name matches.
  # n - Regexp
  def name n
    @files = @files.select { |file| n =~ File.basename(file) }
    self
  end

  #  Predicate matches if browsed file is owned by UNAME.
  def uname un
    @files = @files.select { |file| Etc.getpwuid( File.stat(file).uid ).name == un}
    self
  end

  #  Predicate matches if browsed file is newer than the file at PATH.
  def cnewer path
    time = File.stat(path).ctime
    @files = @files.select { |file| File.stat(file).ctime > time}
    self
  end

  # Return array of matched files
  def all
    @files
  end

  def to_s
    @files.join("\n")
  end
  
  private

  def add_files_from_dir dir, max_depth, curr_depth = 0
    if curr_depth < max_depth
      Dir.entries(dir).each do |file|
        if file != "." && file != ".."
          file = File.join( dir, file )
          @files << file
          add_files_from_dir( file, max_depth, curr_depth + 1 ) if File.ftype(file) == "directory"
        end
      end
    end
  end
end