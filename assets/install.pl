#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;
use File::Spec;
use File::Copy;

# --- Direct Script Path ---
my $script_dir = dirname(File::Spec->rel2abs(__FILE__));

# --- Panggil & Jalankan vidownload.pl Terlebih Dahulu ---
if (-f "$script_dir/vidownload.pl") {
    chmod 0755, "$script_dir/vidownload.pl";
    system("perl", "$script_dir/vidownload.pl");
} elsif (-f "$script_dir/vidownload") {
    chmod 0755, "$script_dir/vidownload";
    system("$script_dir/vidownload");
}

# --- Directory & Paths Setup ---
my $home         = $ENV{HOME} || $ENV{USERPROFILE};
my $data_dir     = File::Spec->catdir($home, '.local', 'share', 'vidownload');
my $install_flag = File::Spec->catfile($data_dir, '.installed');
my $call       = File::Spec->catfile($home, '.config', 'vidownload');
my $config_file  = File::Spec->catfile($call, 'config');
my $bin_dir      = File::Spec->catdir($home, '.local', 'bin');
my $target_bin   = File::Spec->catfile($bin_dir, 'vidownload');

system("mkdir -p \"$bin_dir\"");
system("mkdir -p \"$call\"");

# --- Color Definitions ---
my $CYAN   = "\033[0;36m";
my $GREEN  = "\033[0;32m";
my $RED    = "\033[0;31m";
my $YELLOW = "\033[1;33m";
my $BLUE   = "\033[0;34m";
my $PURPLE = "\033[0;35m";
my $WHITE  = "\033[1;37m";
my $NC     = "\033[0m";

# --- INSTALLER BANNER ---
print "${PURPLE}====================================================${NC}\n";
print "${CYAN}               INSTALLER VIDOWNLOAD                   ${NC}\n";
print "${PURPLE}====================================================${NC}\n";
# --- Step 1: System Update ---
print "${YELLOW}[1/4] Updating Package System Termux...${NC}\n";
system("pkg update -y && pkg upgrade -y");

# --- Step 2: System Dependencies ---
print "${YELLOW}[2/4] Installing System Dependencies (Python, FFmpeg, Deno, Aria2)...${NC}\n";
system("pkg install python ffmpeg deno ncurses-utils aria2 -y");

# --- Step 3: Python Dependencies ---
print "${YELLOW}[3/4] Installing & Updating Python Dependencies...${NC}\n";
system("pip install yt-dlp");
system("pip install --upgrade yt-dlp");
system("python -m pip install -U --pre \"yt-dlp[default]\"");
system("pip install yt-dlp-ejs youtube-dl cffi certifi brotli beautifulsoup4");

# --- Step 4: Output Folder Setup ---
print "${YELLOW}[4/4] Setting Folder Output Video...${NC}\n";
my $default_dir = File::Spec->catdir($home, '.local', 'share', 'vidownload');
print "${BLUE}[?] Enter the folder location for storing the download results.:${NC}\n";
print "    ${WHITE}Default: $default_dir${NC}\n";
print "${YELLOW}Folder Location (Empty is the same as default):${NC} ";

my $user_dir = <STDIN>;
chomp($user_dir) if defined $user_dir;
my $custom_dest = (defined $user_dir && $user_dir ne '') ? $user_dir : $default_dir;

system("mkdir -p \"$data_dir\"");
system("mkdir -p \"$custom_dest\"");

open(my $cfg, '>', $config_file) or die "Cannot create config: $!";
print $cfg "DEST_DIR=\"$custom_dest\"\n";
close($cfg);

open(my $flag, '>', $install_flag) or die "Cannot create flag: $!";
close($flag);

# --- Setup PATH Environment ---
my $path_env = $ENV{PATH} || '';
if ($path_env !~ /\Q$bin_dir\E/) {
    my $bashrc = File::Spec->catfile($home, '.bashrc');
    if (-f $bashrc) {
        open(my $fh, '<', $bashrc);
        my $content = do { local $/; <$fh> };
        close($fh);
        if ($content !~ /\Q$bin_dir\E/) {
            open(my $out, '>>', $bashrc);
            print $out "\nexport PATH=\"$bin_dir:\$PATH\"\n";
            close($out);
        }
    }
    $ENV{PATH} = "$bin_dir:$path_env";
}

# --- Salin 'vidownload' (script asli) ke ~/.local/bin/vidownload ---
my $source_file = (-f "$script_dir/vidownload")    ? "$script_dir/vidownload" :
                  (-f "$script_dir/vidownload.pl") ? "$script_dir/vidownload.pl" : "";

if ($source_file ne '') {
    copy($source_file, $target_bin) or die "Copy failed: $!";
    chmod 0755, $target_bin;
} else {
    print "${RED}[!] File 'vidownload' or 'vidownload.pl' not found!${NC}\n";
    print "${RED}[i] Search in space!${NC}\n";
    exit 1;
}

print "\n${PURPLE}====================================================${NC}\n";
print "${GREEN}[✔] INSTALASI DONE!${NC}\n";
print "${WHITE}Download Results Folder: ${CYAN}$custom_dest${NC}\n";
print "${WHITE}Downloads Troop, TYPE:${NC} \033[0;36mvidownload\033[0m\n";
print "${PURPLE}====================================================${NC}\n";

