#!perl
#_ _ _ _,,_________________________
#<><><>//-----------------------~`
#
# powered by _Jl_E_H_b_!

# TODO: blacklist files, choise couple files
#   red2.pl /z..c/ | find z*c | zshrc for ex

use Env;
use File::Basename;

die <<end
  Usage: rr  [ some piece of filename ] or [ - ]
         tea [ lang ] or [ lang NUM ] or [ nix/dos/etc ]
end
  unless @ARGV;

my ($e, $r) = ($ENV{EDITOR}, 'evince');
my ($x, $xc, $ps) = ($ENV{HOME}, "$ENV{HOME}/.config", 'Choise file >> ');
  "$x/reso/books/" => {
    c => [
      'Yazik programmirovaniya Si. Izdanie 3-e, ispravlennoe.pdf'
      ,'kr.pdf'
    ]
    ,perl => [
      'perl.pdf'
      ,'perlbook.pdf'
      ,'Рэндал Л. Шварц, Брайан Д. Фой и Том Феникс - Perl. Изучаем глубже, 2-е издание - 2007.pdf'
    ]
  }
) if $tea;

$_ = shift;
s/\./\\./;

$_ = 'red2' if /^--?$/;
$$ = $_;

my (@xx, @xxx);
for my $x (@{$pths}){
  last if $tea;

  opendir my $dh, $x;
  @xxx = map { $x . '/' . $_ } grep { /$$/ } readdir $dh;
  for(@xxx){ push @xx, "$e $_" if -T }
  #closedir $dh;
}

for my $x (keys %x){
  #unless($x{$x} ~~ /$_/){ print "$_ " for keys %{$x{$x}}; die "\n"} # хуита
  push @xx, "$r '$x$_' &" for @{$x{$x}{$_}};
}

$_ = shift;
@xx = $xx[$_] if defined $_;

if(@xx > 1){
  @xxx = @xx;
  s/(((evince)|(vim))\s'?)|('\s&)//g for @xxx; # ^_^

  #printf "[%d] %10s\n", $_, $xx[$_] for 0..$xxx;
  # or
  my %h; $h{$_} = $xxx[$_] for 0..$#xx; use DDP; p %h;

  print $ps;
  $_ = <STDIN>;
  die "No selected file, exit!\n" unless /\d/;
  unshift @xx, $xx[$_];
}

die "Not found! ^_^\n" unless @xx;
exec $xx[0];
