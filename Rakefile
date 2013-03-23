require 'rake'

task :default => 'install'

desc "Install dot files under HOME"
task :install => :submodules do
  src_dir = ENV['PWD']
  dest_dir = ENV['HOME']
  abort "Destination #{dest_dir} does not exist" unless File.directory?(dest_dir)
  src_files = [ 'bash_profile', 'hgrc', 'inputrc', 'screenrc', 'tmux.conf',
                'gitignore_global', 'vimrc', 'vim' ]

  src_files.each do |src_file|
    install_link("#{src_dir}/#{src_file}", dest_dir)
  end
  install_gitconfig(src_dir, dest_dir)
end

def install_gitconfig(src_dir, dest_dir)
  name = 'Charles Anderson'
  email = 'master.sparkle@gmail.com'
  fname = "#{src_dir}/gitconfig"
  erb_fname = "#{fname}.erb"
  if File.exist?(fname) && File.mtime(fname) > File.mtime(erb_fname)
    puts "expanded file #{fname} is newer than #{erb_fname}"
  else
    File.open(fname, 'w') do |outfile| 
      outfile.write ERB.new(File.read(erb_fname)).result(binding)
    end
    puts "created expanded file #{fname}"
  end

  install_link(fname, dest_dir)
end

desc "Init and update submodules."
task :submodules do
  sh('git submodule update --init')
end

private

def install_link(src_file, dest_dir)
  dest_file = "#{dest_dir}/.#{File.basename(src_file)}"
  puts "install #{src_file} --> #{dest_file}"
  unless File.exists?(src_file)
    puts "** #{src_file} does not exist - skipping"
    return
  end

  if File.exists?(dest_file)
    if File.symlink?(dest_file)
      if File.readlink(dest_file) == src_file
        return
      end
    end

    orig_file = "#{dest_file}.orig"
    puts "  saving #{dest_file} as #{orig_file}"
    File.unlink(orig_file) if File.exists?(orig_file)
    File.rename(dest_file, orig_file)
  end

  abort "** #{dest_file} should not exist" if File.exists?(dest_file)
  File.symlink(src_file, dest_file)
end
