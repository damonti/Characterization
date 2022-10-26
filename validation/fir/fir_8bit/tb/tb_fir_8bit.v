`timescale 10ns/1ns 

module tb_fir;


parameter N = 8;
parameter STEP   = 10; 
integer i, j, fd;
//reg [N-1:0] memory_read [99:0];
reg [N-1:0] inj_data;  
integer count, seed;
reg clk, rst, dout_busy, din_vld; 

 // Inputs
reg [N-1:0] coeffs_table_7, coeffs_table_6, coeffs_table_5,
       coeffs_table_4, coeffs_table_3, coeffs_table_2, coeffs_table_1,
       coeffs_table_0, din_data;
 // Outputs
 wire [N+2:0] dout_data;
 wire dout_vld;

always #(STEP/2) begin
        clk <= ~clk;
end


always #( STEP ) begin     
        count = count + 1; //to stop the simulation
        seed  = seed  + 1; //??
end    


fir_8bit fir_8bit (
    .coeffs_table_7(coeffs_table_7), 
    .coeffs_table_6(coeffs_table_6), 
    .coeffs_table_5(coeffs_table_5),
    .coeffs_table_4(coeffs_table_4), 
    .coeffs_table_3(coeffs_table_3), 
    .coeffs_table_2(coeffs_table_2), 
    .coeffs_table_1(coeffs_table_1),
    .coeffs_table_0(coeffs_table_0),
    .din_data(din_data),
    .dout_data(dout_data),
    .clk(clk),
    .rst(rst),
    .din_vld(din_vld),
    .dout_busy(dout_busy),
    .dout_vld(dout_vld)
 );

initial begin
    //initialize input
    $dumpvars(0, tb_fir.fir_8bit);   
    $dumpoff;  
    
/* Initialization */            
        #0
        $write("Start clock %d \n", count);                              
        clk <= {1'b1};
        rst <= {1'b0};
        din_vld <= {1'b0};
        dout_busy <= {1'b1};
        coeffs_table_0 <= 0;
        coeffs_table_1 <= 0;
        coeffs_table_2 <= 0;
        coeffs_table_3 <= 0;
        coeffs_table_4 <= 0;
        coeffs_table_5 <= 0;
        coeffs_table_6 <= 0;
        coeffs_table_7 <= 0;
        //$readmemb("stimuli.txt", memory_read);                      
        count   = 0;
        din_data <= 0;
        #(STEP)
        #(STEP)
        $dumpon;
        rst <= {1'b1};
        #(STEP)
        coeffs_table_0 <= 1;
        coeffs_table_1 <= 1;
        coeffs_table_2 <= 1;
        coeffs_table_3 <= 1;
        coeffs_table_4 <= 1;
        coeffs_table_5 <= 1;
        coeffs_table_6 <= 1;
        coeffs_table_7 <= 1;
        din_vld <= {1'b1};
        dout_busy <= {1'b0};
        din_data <= {8'b00000001};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000010};
        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000011};
        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000100};
        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000101};
        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000110};

        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000111};

        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_data <= {8'b00000101};

        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        //din_data <= {8'b00000111};

        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        //din_data <= {8'b00000111};

        #(STEP)
        dout_busy <= {1'b0};
        #(STEP)
        dout_busy <= {1'b1};
        din_vld <= {1'b1};
        //din_data <= {8'b00000111};



        // for (i = 0; i < 10; i = i + 1) begin //10 packets are sent. each packet has $PAYLOAD data flits
        //         send_data( PAYLOAD );
        //         #(STEP*7)         // Link utilization 4/13=0.30 (flit_rate injection)
        //         $write("------------------------\n");
        // end
        // fd = $fopen("./../tb/stimuli.txt", "r");
        // //if (!fd) $display("could not read file");
        // while (!$feof(fd)) begin
        //         $fscanf(fd,"%b", inj_data);
        //         $display("inj=%b", inj_data);
        //         #(STEP)
        //         dout_busy <= {1'b1};
        //         din_data <= inj_data;
        //         #(STEP)
        //         dout_busy <= {1'b0}; 
        // end
        #(STEP)
        $write("------------------------\n");
        $dumpoff;
        #(STEP)
        $write("Stop clock %d \n", count);
        $finish;
end

// task send_data; 
// integer j;
// reg [N-1:0] memory_read [99:0];
// reg [N-1:0] inj_data;  

// begin
//             /* data transfer */ 
// 	for (j=0; j<100; j= j+1) 
//     begin
//         inj_data = memory_read[j];
//         din_data <= inj_data; 
//     end
// end

// endtask
      

always #( STEP ) begin 
        $write("input={%x} ", inj_data);
        $write("input fir={%x} ", din_data);
        $write("output={%x} ", dout_data); 
        $write("CLK = %d, %b", count, clk);
        $write("\n"); 
end 

endmodule
