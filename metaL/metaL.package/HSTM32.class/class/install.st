install
install
	type := 'stm32'.
	f030 := HSTM32 initialize: #f030.
	f030 at: #suffix put: #F4P6.