# This class configures the ipsec.conf file and creates
# any directories needed by this file that are not already there.
#
class libreswan::config {
  assert_private()

  # set up the /etc/ipsec.conf file and any directories that
  # might be defined in it.
  # have to copy variables local because scope and scope.lookup don't work
  # in erb if statements.
  $myid                = $::libreswan::myid
  $protostack          = $::libreswan::protostack
  $interfaces          = $::libreswan::interfaces
  $listen              = $::libreswan::listen
  $ikeport             = $::libreswan::ikeport
  $nflog_all           = $::libreswan::nflog_all
  $nat_ikeport         = $::libreswan::nat_ikeport
  $keep_alive          = $::libreswan::keep_alive
  $virtual_private     = $::libreswan::virtual_private
  $myvendorid          = $::libreswan::myvendorid
  $nhelpers            = $::libreswan::nhelpers
#seedbits
#secctx-attr-type
  $plutofork           = $::libreswan::plutofork
  $crlcheckinterval    = $::libreswan::crlcheckinterval
  $strictcrlpolicy     = $::libreswan::strictcrlpolicy
  $ocsp_enable         = $::libreswan::ocsp_enable
  $ocsp_strict         = $::libreswan::ocsp_strict
  $ocsp_timeout        = $::libreswan::ocsp_timeout
  $ocsp_uri            = $::libreswan::ocsp_uri
  $ocsp_trustname      = $::libreswan::ocsp_trustname
  $syslog              = $::libreswan::syslog
  $klipsdebug          = $::libreswan::klipsdebug
  $plutodebug          = $::libreswan::plutodebug
  $uniqueids           = $::libreswan::uniqueids
  $plutorestartoncrash = $::libreswan::plutorestartoncrash
  $logfile             = $::libreswan::logfile
  $logappend           = $::libreswan::logappend
  $logtime             = $::libreswan::logtime
  $ddos_mode           = $::libreswan::ddos_mode
  $ddos_ike_treshold   = $::libreswan::ddos_ike_treshold
#max-halfopen-ike         = $::libreswan::
#shuntlifetime         = $::libreswan::
#xfrmlifetime         = $::libreswan::
  $dumpdir             = $::libreswan::dumpdir
  $statsbin            = $::libreswan::statsbin
  $ipsecdir            = $::libreswan::ipsecdir
  $secretsfile         = $::libreswan::secretsfile
  $perpeerlog          = $::libreswan::perpeerlog
  $perpeerlogdir       = $::libreswan::perpeerlogdir
  $fragicmp            = $::libreswan::fragicmp
  $hidetos             = $::libreswan::hidetos
  $overridemtu         = $::libreswan::overridemtu

  file { '/etc/ipsec.conf':
    ensure  => file,
    owner   => root,
    mode    => '0400',
    notify  => Service['ipsec'],
    content => template('libreswan/etc/ipsec.conf.erb')
  }
  file { $::libreswan::dumpdir:
    ensure => directory,
    owner  => root,
    mode   => '0700',
    before => File['/etc/ipsec.conf']
  }
  if $::libreswan::logfile {
    file {$::libreswan::logfile:
      ensure => file,
      owner  => root,
      mode   => '0600',
      before => File['/etc/ipsec.conf']
    }
  }
}
