Barista.configure do |c|
  c.no_wrap = true
  c.change_output_prefix! 'shuriken', 'vendor/shuriken'
end
# Grrr!
Barista::Compiler.bin_path = "/usr/local/bin/coffee" if Rails.env.production?
