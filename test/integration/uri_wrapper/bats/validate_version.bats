@test "it installs 17" {
  /usr/local/bin/erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell | grep "17"
}
