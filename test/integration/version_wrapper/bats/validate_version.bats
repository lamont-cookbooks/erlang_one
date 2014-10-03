@test "it installs R16B03" {
  /usr/local/bin/erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell | grep "R16B03"
}
