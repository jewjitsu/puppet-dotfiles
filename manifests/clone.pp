define dotfiles::clone(
    $gituser,
    $giturl  = "git://github.com",
    $project = "dotfiles",
    $branch  = "master",
    $homedir,
    $creates,
  ) {

  $ssh = inline_template("<%= @giturl[0..3] %>")
  if $ssh == 'git@' {
    $url = "$giturl:"
  } else {
    $url = "$giturl/"
  }

  exec { "clone ${gituser} dotfiles for ${title}":
    cwd     => "${homedir}",
    command => "git clone ${url}${gituser}/${project}.git --branch $branch",
    creates => "${creates}",
    user    => "${title}",
    require => Package['git'],
  }
}
