#ifdef ioConfig_PIN
	if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
		if ( fir0 != NULL ) {
			esc_trace_signal( &fir0->clk, ( std::string(name()) + std::string( ".fir.clk" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->rst, ( std::string(name()) + std::string( ".fir.rst" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->coeffs, ( std::string(name()) + std::string( ".fir.coeffs" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->din.busy, ( std::string(name()) + std::string( ".fir.din.busy" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->din.vld, ( std::string(name()) + std::string( ".fir.din.vld" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->din.data, ( std::string(name()) + std::string( ".fir.din.data" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->dout.busy, ( std::string(name()) + std::string( ".fir.dout.busy" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->dout.vld, ( std::string(name()) + std::string( ".fir.dout.vld" ) ).c_str(), esc_trace_vcd );
			esc_trace_signal( &fir0->dout.data, ( std::string(name()) + std::string( ".fir.dout.data" ) ).c_str(), esc_trace_vcd );
		}
	}
	if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
		if ( fir0 != NULL ) {
			esc_trace_signal( &fir0->clk, ( std::string(name()) + std::string( ".fir.clk" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->rst, ( std::string(name()) + std::string( ".fir.rst" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->coeffs, ( std::string(name()) + std::string( ".fir.coeffs" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->din.busy, ( std::string(name()) + std::string( ".fir.din.busy" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->din.vld, ( std::string(name()) + std::string( ".fir.din.vld" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->din.data, ( std::string(name()) + std::string( ".fir.din.data" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->dout.busy, ( std::string(name()) + std::string( ".fir.dout.busy" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->dout.vld, ( std::string(name()) + std::string( ".fir.dout.vld" ) ).c_str(), esc_trace_fsdb );
			esc_trace_signal( &fir0->dout.data, ( std::string(name()) + std::string( ".fir.dout.data" ) ).c_str(), esc_trace_fsdb );
		}
	}
#endif

