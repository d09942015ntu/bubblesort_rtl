

////////////////////////////////////////////////
`timescale 1ns/1ps

module testbench;

	// Inputs
	reg clk;
	reg rst;
	reg load0_i;
	reg load1_i;
	reg load2_i;
	reg load3_i;
	reg load4_i;
	reg load5_i;
	reg load6_i;
	reg [7:0] writedata0_i;
	reg [7:0] writedata1_i;
	reg [7:0] writedata2_i;
	reg [7:0] writedata3_i;
	reg [7:0] writedata4_i;
	reg [7:0] writedata5_i;
	reg [7:0] writedata6_i;
	reg start_i;
	reg abort_i;

	// Outputs
	wire [7:0] readdata0_o_gt;
	wire [7:0] readdata1_o_gt;
	wire [7:0] readdata2_o_gt;
	wire [7:0] readdata3_o_gt;
	wire [7:0] readdata4_o_gt;
	wire [7:0] readdata5_o_gt;
	wire [7:0] readdata6_o_gt;
	wire done_o_gt;
	wire interrupt_o_gt;

	wire [7:0] readdata0_o_dut;
	wire [7:0] readdata1_o_dut;
	wire [7:0] readdata2_o_dut;
	wire [7:0] readdata3_o_dut;
	wire [7:0] readdata4_o_dut;
	wire [7:0] readdata5_o_dut;
	wire [7:0] readdata6_o_dut;
	wire done_o_dut;
	wire interrupt_o_dut;

	// Instantiate the Unit Under Test
	bublesort_gt #(8,7)
	b_gt (
		.clk(clk), 
		.rst(rst), 
		.load_i({load6_i,load5_i,load4_i,load3_i,load2_i,load1_i,load0_i}), 
		.writedata_i({writedata6_i,writedata5_i,writedata4_i,writedata3_i,writedata2_i,writedata1_i,writedata0_i}), 
		.readdata_o({readdata6_o_gt,readdata5_o_gt,readdata4_o_gt,readdata3_o_gt,readdata2_o_gt,readdata1_o_gt,readdata0_o_gt}), 
		.start_i(start_i), 
		.done_o(done_o_gt), 
		.interrupt_o(interrupt_o_gt), 
		.abort_i(abort_i)
	);

	bublesort #(8,7)
	b_dut (
		.clk(clk), 
		.rst(rst), 
		.load_i({load6_i,load5_i,load4_i,load3_i,load2_i,load1_i,load0_i}), 
		.writedata_i({writedata6_i,writedata5_i,writedata4_i,writedata3_i,writedata2_i,writedata1_i,writedata0_i}), 
		.readdata_o({readdata6_o_dut,readdata5_o_dut,readdata4_o_dut,readdata3_o_dut,readdata2_o_dut,readdata1_o_dut,readdata0_o_dut}), 
		.start_i(start_i), 
		.done_o(done_o_dut), 
		.interrupt_o(interrupt_o_dut), 
		.abort_i(abort_i)
	);

	initial begin
	    $display("Start");
        // Dump file
        $dumpfile("waveform.vcd");  // Specify the output dump file name
        $dumpvars(0, testbench);    // Dump all variables in the testbench
		// Initialize Inputs
		clk = 0;
		rst = 1;
		load0_i = 0;
		writedata0_i = 0;
		writedata1_i = 0;
		writedata2_i = 0;
		writedata3_i = 0;
		writedata4_i = 0;
		writedata5_i = 0;
		writedata6_i = 0;
		load1_i = 0;
		load2_i = 0;
		load3_i = 0;
		load4_i = 0;
		load5_i = 0;
		load6_i = 0;
		start_i = 0;
		abort_i = 0;
         
		// Wait 10 ns
		#10;
        
		// Stimulus 
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;

        clk = 1; #1;
            rst = 0;
            #4; clk = 0; #5;

        clk = 1; #5 clk = 0; #5;

        clk = 1; #1;
            writedata0_i = 80;
            writedata1_i = 40;
            writedata2_i = 10;
            writedata3_i = 20;
            writedata4_i = 30;
            writedata5_i = 70;
            writedata6_i = 50;
            load0_i = 1;
            load1_i = 1;
            load2_i = 1;
            load3_i = 1;
            load4_i = 1;
            load5_i = 1;
            load6_i = 1;
            #4; clk = 0; #5;

	    $display("data0_i:%d, data1_i:%d, data2_i:%d, data3_i:%d, data4_i:%d, data5_i:%d, data6_i:%d",
			writedata0_i, writedata1_i, writedata2_i, writedata3_i, writedata4_i, writedata5_i, writedata6_i);

        clk = 1; #1;
            writedata0_i = 0;
            writedata1_i = 0;
            writedata2_i = 0;
            writedata3_i = 0;
            writedata4_i = 0;
            writedata5_i = 0;
            writedata6_i = 0;
            load0_i = 0;
            load1_i = 0;
            load2_i = 0;
            load3_i = 0;
            load4_i = 0;
            load5_i = 0;
            load6_i = 0;
            #4; clk = 0; #5;

        clk = 1; #1;
            start_i = 1;
            #4; clk = 0; #5;

        clk = 1; #1;
            start_i = 0;
            #4; clk = 0; #5;

        while(!interrupt_o_gt) begin
            clk = 1; #5 clk = 0; #5;
        end

        while(!interrupt_o_dut) begin
            clk = 1; #5 clk = 0; #5;
        end
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;
        clk = 1; #5 clk = 0; #5;

		assert (readdata0_o_dut==readdata0_o_gt);
		assert (readdata1_o_dut==readdata1_o_gt);
		assert (readdata2_o_dut==readdata2_o_gt);
		assert (readdata3_o_dut==readdata3_o_gt);
		assert (readdata4_o_dut==readdata4_o_gt);
		assert (readdata5_o_dut==readdata5_o_gt);
		assert (readdata6_o_dut==readdata6_o_gt);

	    $display(" gt: data0_i:%d, data1_i:%d, data2_i:%d, data3_i:%d, data4_i:%d, data5_i:%d, data6_i:%d",
			readdata0_o_gt, readdata1_o_gt, readdata2_o_gt, readdata3_o_gt, readdata4_o_gt, readdata5_o_gt, readdata6_o_gt);

	    $display("dut: data0_i:%d, data1_i:%d, data2_i:%d, data3_i:%d, data4_i:%d, data5_i:%d, data6_i:%d",
			readdata0_o_dut, readdata1_o_dut, readdata2_o_dut, readdata3_o_dut, readdata4_o_dut, readdata5_o_dut, readdata6_o_dut);

    $finish ;

	end
endmodule

