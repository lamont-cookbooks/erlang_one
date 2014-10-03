@test "it installs R15B01" {
  /usr/local/bin/erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell | grep "R15B01"
}
