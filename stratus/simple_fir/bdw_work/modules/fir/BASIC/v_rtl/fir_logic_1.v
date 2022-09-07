// Generated by stratus_hls 19.25-s100  (93142.260418)
// Wed Sep  7 10:39:56 2022
// from fir.cc

`timescale 1ps / 1ps

      
module fir_logic_1(clk, rst, coeffs_table_1, coeffs_table_0, coeffs_table_2, coeffs_table_3, coeffs_table_4, coeffs_table_5, coeffs_table_6, din_data, coeffs_table_7, din_busy, din_vld, dout_vld, dout_busy, dout_data);

      input clk;
      input rst;
      input [7:0] coeffs_table_1;
      input [7:0] coeffs_table_0;
      input [7:0] coeffs_table_2;
      input [7:0] coeffs_table_3;
      input [7:0] coeffs_table_4;
      input [7:0] coeffs_table_5;
      input [7:0] coeffs_table_6;
      input [7:0] din_data;
      input [7:0] coeffs_table_7;
      input din_vld;
      input dout_busy;
      output din_busy;
      output dout_vld;
      output [10:0] dout_data;
      reg dout_m_req_m_prev_trig_req;
      reg dout_m_unacked_req;
      wire fir_Xor_1Ux1U_1U_1_4_out1;
      wire fir_Or_1Ux1U_1U_4_5_out1;
      wire fir_And_1Ux1U_1U_4_27_out1;
      wire fir_And_1Ux1U_1U_4_25_out1;
      wire fir_Not_1U_1U_4_24_out1;
      wire fir_And_1Ux1U_1U_4_26_out1;
      reg fir_N_Muxb_1_2_8_4_1_out1;
      reg din_m_unvalidated_req;
      wire fir_gen_busy_r_1_2_gnew_req;
      wire fir_gen_busy_r_1_2_gnew_busy;
      wire fir_gen_busy_r_1_2_gdiv;
      wire fir_gen_busy_r_1_2_gen_busy_din_m_data_is_invalid_next;
      wire din_m_data_is_valid;
      wire t_18;
      wire t_15;
      wire rdy_0;
      reg vld_0;
      reg rdy_1;
      wire[2:0] fir_gen_busy_r_1_2_out1;
      wire t_11;
      reg vld_1;
      reg rdy_2;
      wire fir_And_1Ux1U_1U_1_6_out1;
      reg cycle2_state;
      wire t_13;
      reg global_state;
      wire[10:0] fir_Mul_8Ux8U_11U_4_22_out1;
      reg[7:0] din_m_stall_reg;
      reg din_m_stall_reg_full;
      wire[10:0] fir_Mul_8Ux8U_11U_4_19_out1;
      wire[10:0] fir_Add_11Ux11U_11U_4_18_out1;
      wire[10:0] fir_Mul_8Ux8U_11U_4_17_out1;
      wire[10:0] fir_Add_11Ux11U_11U_4_16_out1;
      wire[10:0] fir_Mul_8Ux8U_11U_4_15_out1;
      wire[10:0] fir_Add_11Ux11U_11U_4_14_out1;
      wire[10:0] fir_Mul_8Ux8U_11U_4_13_out1;
      wire[10:0] fir_Add_11Ux11U_11U_4_12_out1;
      wire[10:0] fir_Mul_8Ux8U_11U_4_11_out1;
      wire[10:0] fir_Add_11Ux11U_11U_4_10_out1;
      wire[10:0] fir_Mul_8Ux8U_11U_4_9_out1;
      wire[10:0] fir_Mul_8Ux8U_11U_4_8_out1;
      reg[7:0] s_reg_9;
      reg[7:0] s_reg_8;
      wire[10:0] fir_Add_11Ux11U_11U_4_20_out1;
      reg[10:0] s_reg_14;
      reg en_0;
      reg[7:0] s_reg_13;
      reg[7:0] s_reg_12;
      reg[7:0] s_reg_11;
      reg[7:0] s_reg_10;
      reg[7:0] shift_reg_7_mi12;
      reg[7:0] fir_N_Mux_8_2_10_4_21_out1;
      reg cycle1_state;
      wire fir_Not_1U_1U_1_7_out1;
      reg dout_m_req_m_trig_req;
      reg din_m_stalling;
      wire t_3;
      wire t_2;
      wire t_1;
      wire t_0;
      reg din_m_busy_req_0;
      wire[10:0] fir_Add_11Ux11U_11U_4_23_out1;
      reg[6:0] dout_data_slice;
      reg en_1;

         // rtl_process:fir_logic_1/drive_dout_data_slice
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_dout_data_slice
         // at: cynw_p2p.h:5279:13
         always @(posedge clk)
          begin :drive_dout_data_slice
            case (en_1) 

               1'b1:                begin
                  // op:FirThread/OP120
                  // at: cynw_p2p.h:5279:13
                  // Call Stack: 
                  // in function nb_put_work called from cynw_p2p.h:5064:7
                  // in function put called from fir.cc:60:14
                  dout_data_slice <= fir_Add_11Ux11U_11U_4_23_out1[10:4];
               end
               
               1'b0:                begin
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_din_m_busy_req_0
         // Sharing or Control mux
         // Sharing/Controlling 5 operation(s) on drive_din_m_busy_req_0
         // at: cynw_p2p.h:1806:17
         // at: cynw_p2p.h:1761:12
         // at: cynw_p2p.h:1515:2
         // at: cynw_p2p.h:1595:7
         // at: cynw_p2p.h:1620:7
         always @(posedge clk)
          begin :drive_din_m_busy_req_0
            if (rst == 1'b0) begin
               // op:FirThread/OP64
               // at: cynw_p2p.h:1515:2
               // Call Stack: 
               // in function reset called from fir.cc:33:13
               din_m_busy_req_0 <= 1'd1;
            end
            else begin
               case ({t_1, t_0}) 

                  2'd1:                   begin
                     din_m_busy_req_0 <= 1'd1;
                  end
                  
                  2'd2:                   begin
                     din_m_busy_req_0 <= 1'd0;
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_din_m_stalling
         // Sharing or Control mux
         // Sharing/Controlling 3 operation(s) on drive_din_m_stalling
         // at: cynw_p2p.h:1532:33
         // at: cynw_p2p.h:1824:38
         // at: cynw_p2p.h:1849:47
         always @(t_3 or t_2)
          begin :drive_din_m_stalling
            case ({t_3, t_2}) 

               2'd2:                begin
                  din_m_stalling = 1'd1;
               end
               
               default:                begin
                  din_m_stalling = 1'd0;
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_dout_m_req_m_trig_req
         // Sharing or Control mux
         // Sharing/Controlling 5 operation(s) on drive_dout_m_req_m_trig_req
         // at: cynw_comm_util.h:1421:27
         // at: cynw_comm_util.h:1405:52
         // at: cynw_comm_util.h:1446:26
         // at: cynw_comm_util.h:1366:7
         // at: cynw_comm_util.h:1359:2
         always @(posedge clk)
          begin :drive_dout_m_req_m_trig_req
            if (rst == 1'b0) begin
               // op:FirThread/OP66
               // at: cynw_comm_util.h:1366:7
               // Call Stack: 
               // in function reset called from cynw_p2p.h:5088:13
               // in function reset called from fir.cc:34:14
               dout_m_req_m_trig_req <= 1'd0;
            end
            else begin
               case (t_2) 

                  1'b1:                   begin
                     // op:FirThread/OP121
                     // at: cynw_comm_util.h:1359:13
                     // Call Stack: 
                     // in function trig called from cynw_p2p.h:5280:8
                     // in function nb_put_work called from cynw_p2p.h:5064:7
                     // in function put called from fir.cc:60:14
                     dout_m_req_m_trig_req <= fir_Not_1U_1U_1_7_out1;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_shift_reg_7_mi12
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_shift_reg_7_mi12
         // at: fir.cc:56:43 fir.cc:47:18
         always @(fir_N_Mux_8_2_10_4_21_out1 or cycle1_state)
          begin :drive_shift_reg_7_mi12
            if (cycle1_state) begin
               shift_reg_7_mi12 = 8'd000;
            end
            else begin
               shift_reg_7_mi12 = fir_N_Mux_8_2_10_4_21_out1;
            end
         end

         // rtl_process:fir_logic_1/drive_s_reg_10
         // Sharing or Control mux
         // Sharing/Controlling 2 operation(s) on drive_s_reg_10
         // at: fir.cc:37:13
         // at: fir.cc:46:22
         always @(posedge clk)
          begin :drive_s_reg_10
            if (rst == 1'b0) begin
               // op:FirThread/OP69
               // at: fir.cc:37:13
               // Call Stack: 
               // in function FirThread called from fir.cc:37:13
               s_reg_10 <= 8'd000;
            end
            else begin
               case (t_1) 

                  1'b1:                   begin
                     s_reg_10 <= s_reg_11;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_s_reg_11
         // Sharing or Control mux
         // Sharing/Controlling 2 operation(s) on drive_s_reg_11
         // at: fir.cc:37:13
         // at: fir.cc:46:22
         always @(posedge clk)
          begin :drive_s_reg_11
            if (rst == 1'b0) begin
               // op:FirThread/OP70
               // at: fir.cc:37:13
               // Call Stack: 
               // in function FirThread called from fir.cc:37:13
               s_reg_11 <= 8'd000;
            end
            else begin
               case (t_1) 

                  1'b1:                   begin
                     s_reg_11 <= s_reg_12;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_s_reg_12
         // Sharing or Control mux
         // Sharing/Controlling 2 operation(s) on drive_s_reg_12
         // at: fir.cc:37:13
         // at: fir.cc:46:22
         always @(posedge clk)
          begin :drive_s_reg_12
            if (rst == 1'b0) begin
               // op:FirThread/OP71
               // at: fir.cc:37:13
               // Call Stack: 
               // in function FirThread called from fir.cc:37:13
               s_reg_12 <= 8'd000;
            end
            else begin
               case (t_1) 

                  1'b1:                   begin
                     s_reg_12 <= s_reg_13;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_s_reg_13
         // Sharing or Control mux
         // Sharing/Controlling 2 operation(s) on drive_s_reg_13
         // at: fir.cc:37:13
         // at: fir.cc:46:22
         always @(posedge clk)
          begin :drive_s_reg_13
            if (rst == 1'b0) begin
               // op:FirThread/OP72
               // at: fir.cc:37:13
               // Call Stack: 
               // in function FirThread called from fir.cc:37:13
               s_reg_13 <= 8'd000;
            end
            else begin
               case (t_1) 

                  1'b1:                   begin
                     s_reg_13 <= shift_reg_7_mi12;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_s_reg_14
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_s_reg_14
         // at: fir.cc:56:19
         always @(posedge clk)
          begin :drive_s_reg_14
            case (en_0) 

               1'b1:                begin
                  // op:FirThread/OP117
                  // at: fir.cc:56:19
                  // Call Stack: 
                  // in function FirThread called from fir.cc:56:19
                  s_reg_14 <= fir_Add_11Ux11U_11U_4_20_out1;
               end
               
               1'b0:                begin
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_s_reg_8
         // Sharing or Control mux
         // Sharing/Controlling 2 operation(s) on drive_s_reg_8
         // at: fir.cc:37:13
         // at: fir.cc:46:22
         always @(posedge clk)
          begin :drive_s_reg_8
            if (rst == 1'b0) begin
               // op:FirThread/OP67
               // at: fir.cc:37:13
               // Call Stack: 
               // in function FirThread called from fir.cc:37:13
               s_reg_8 <= 8'd000;
            end
            else begin
               case (t_1) 

                  1'b1:                   begin
                     s_reg_8 <= s_reg_9;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_process:fir_logic_1/drive_s_reg_9
         // Sharing or Control mux
         // Sharing/Controlling 2 operation(s) on drive_s_reg_9
         // at: fir.cc:37:13
         // at: fir.cc:46:22
         always @(posedge clk)
          begin :drive_s_reg_9
            if (rst == 1'b0) begin
               // op:FirThread/OP68
               // at: fir.cc:37:13
               // Call Stack: 
               // in function FirThread called from fir.cc:37:13
               s_reg_9 <= 8'd000;
            end
            else begin
               case (t_1) 

                  1'b1:                   begin
                     s_reg_9 <= s_reg_10;
                  end
                  
                  1'b0:                   begin
                  end
                  
               endcase

            end
         end

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_8
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_8_out1 = {3'b000, coeffs_table_1}*{3'b000, s_reg_9};

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_9
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_9_out1 = {3'b000, coeffs_table_0}*{3'b000, s_reg_8};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_10
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_10_out1 = fir_Mul_8Ux8U_11U_4_9_out1 + fir_Mul_8Ux8U_11U_4_8_out1;

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_11
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_11_out1 = {3'b000, coeffs_table_2}*{3'b000, s_reg_10};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_12
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_12_out1 = fir_Mul_8Ux8U_11U_4_11_out1 + fir_Add_11Ux11U_11U_4_10_out1;

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_13
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_13_out1 = {3'b000, coeffs_table_3}*{3'b000, s_reg_11};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_14
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_14_out1 = fir_Mul_8Ux8U_11U_4_13_out1 + fir_Add_11Ux11U_11U_4_12_out1;

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_15
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_15_out1 = {3'b000, coeffs_table_4}*{3'b000, s_reg_12};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_16
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_16_out1 = fir_Mul_8Ux8U_11U_4_15_out1 + fir_Add_11Ux11U_11U_4_14_out1;

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_17
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_17_out1 = {3'b000, coeffs_table_5}*{3'b000, s_reg_13};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_18
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_18_out1 = fir_Mul_8Ux8U_11U_4_17_out1 + fir_Add_11Ux11U_11U_4_16_out1;

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_19
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_19_out1 = {3'b000, coeffs_table_6}*{3'b000, shift_reg_7_mi12};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_20
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_20_out1 = fir_Mul_8Ux8U_11U_4_19_out1 + fir_Add_11Ux11U_11U_4_18_out1;

         // rtl_instance:fir_logic_1/fir_N_Mux_8_2_10_4_21
         // Resource=fir_N_Mux_8_2_10_4, Function=mux : Inputs=8,8,1 Outputs=8
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1551:2
         always @(din_data or din_m_stall_reg or din_m_stall_reg_full)
          begin :fir_N_Mux_8_2_10_4_21
            if (din_m_stall_reg_full) begin
               fir_N_Mux_8_2_10_4_21_out1 = din_m_stall_reg;
            end
            else begin
               fir_N_Mux_8_2_10_4_21_out1 = din_data;
            end
         end

         // rtl_instance:fir_logic_1/fir_Mul_8Ux8U_11U_4_22
         // Resource=fir_Mul_8Ux8U_11U_4, Function=mul : Inputs=8,8 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:32
         assign fir_Mul_8Ux8U_11U_4_22_out1 = {3'b000, coeffs_table_7}*{3'b000, fir_N_Mux_8_2_10_4_21_out1};

         // rtl_instance:fir_logic_1/fir_Add_11Ux11U_11U_4_23
         // Resource=fir_Add_11Ux11U_11U_4, Function=add : Inputs=11,11 Outputs=11
         // Implements 1 operation(s)
         // at: fir.cc:56:19
         assign fir_Add_11Ux11U_11U_4_23_out1 = fir_Mul_8Ux8U_11U_4_22_out1 + s_reg_14;

         // rtl_process:fir_logic_1/drive_rdy_2
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_rdy_2
         always @(fir_And_1Ux1U_1U_1_6_out1 or cycle2_state or t_13 or global_state)
          begin :drive_rdy_2
            if (global_state) begin
               case ({cycle2_state, t_13}) 

                  2'd1:                   begin
                     // op:FirThread/OP124
                     // at: cynw_p2p.h:5072:2
                     // Call Stack: 
                     // in function put called from fir.cc:60:14
                     rdy_2 = !fir_And_1Ux1U_1U_1_6_out1;
                  end
                  
                  default:                   begin
                     // op:FirThread/OP124
                     // at: cynw_p2p.h:5072:2
                     // Call Stack: 
                     // in function put called from fir.cc:60:14
                     rdy_2 = 1'b1;
                  end
                  
               endcase

            end
            else begin
               rdy_2 = 1'b0;
            end
         end

         // rtl_process:fir_logic_1/drive_vld_1
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_vld_1
         always @(posedge clk)
          begin :drive_vld_1
            case (global_state) 

               1'b1:                begin
                  vld_1 <= en_1 | vld_1 & !rdy_2;
               end
               
               1'b0:                begin
                  vld_1 <= 1'b0;
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_rdy_1
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_rdy_1
         always @(cycle1_state or global_state or rdy_2 or vld_1 or fir_gen_busy_r_1_2_out1[0] or t_11)
          begin :drive_rdy_1
            if (global_state) begin
               case ({cycle1_state, t_11}) 

                  2'd1:                   begin
                     // op:FirThread/OP90
                     // at: cynw_p2p.h:1464:9
                     // Call Stack: 
                     // in function get called from fir.cc:47:28
                     rdy_1 = (!vld_1 | rdy_2) & !fir_gen_busy_r_1_2_out1[0];
                  end
                  
                  default:                   begin
                     // op:FirThread/OP90
                     // at: cynw_p2p.h:1464:9
                     // Call Stack: 
                     // in function get called from fir.cc:47:28
                     rdy_1 = !vld_1 | rdy_2;
                  end
                  
               endcase

            end
            else begin
               rdy_1 = 1'b0;
            end
         end

         // rtl_process:fir_logic_1/drive_vld_0
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_vld_0
         always @(posedge clk)
          begin :drive_vld_0
            case (global_state) 

               1'b1:                begin
                  vld_0 <= en_0 | vld_0 & !rdy_1;
               end
               
               1'b0:                begin
                  vld_0 <= 1'b0;
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_rdy_0
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_rdy_0
         assign rdy_0 = !vld_0 | rdy_1;

         // rtl_process:fir_logic_1/drive_en_0
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_en_0
         always @(global_state or rdy_0)
          begin :drive_en_0
            if (global_state) begin
               en_0 = rdy_0;
            end
            else begin
               en_0 = 1'b0;
            end
         end

         // rtl_process:fir_logic_1/drive_en_1
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_en_1
         always @(global_state or rdy_1 or vld_0)
          begin :drive_en_1
            if (global_state) begin
               en_1 = vld_0 & rdy_1;
            end
            else begin
               en_1 = 1'b0;
            end
         end

         // rtl_process:fir_logic_1/drive_cycle1_state
         // FSM Control Mux
         // FSM Control for thread behavior:FirThread
         // BB9 : PROTO_2
         //   SRCLOC: cynw_p2p.h:1466:11
         //    FSM: global_state == 1  && cycle1_state == 0
         always @(posedge clk)
          begin :drive_cycle1_state
            case ({t_1, t_15}) 

               2'd1:                begin
                  cycle1_state <= 1'b1;
               end
               
               2'd2:                begin
                  // basic_block:FirThread/BB9
                  cycle1_state <= 1'b0;
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_cycle2_state
         // FSM Control Mux
         // FSM Control for thread behavior:FirThread
         // BB16 : PROTO_3
         //   SRCLOC: cynw_p2p.h:5074:4
         //    FSM: global_state == 1  && cycle2_state == 0
         always @(posedge clk)
          begin :drive_cycle2_state
            case ({t_18, t_15}) 

               2'd1:                begin
                  cycle2_state <= 1'b1;
               end
               
               2'd2:                begin
                  cycle2_state <= cycle1_state;
               end
               
            endcase

         end

         // rtl_process:fir_logic_1/drive_global_state
         // FSM Control Mux
         // FSM Control for thread behavior:FirThread
         // BB4 : PROTO_1
         //   SRCLOC: fir.cc:35:9
         //    FSM: global_state == 0
         // BB9 : PROTO_2
         //   SRCLOC: cynw_p2p.h:1466:11
         //    FSM: global_state == 1  && cycle1_state == 0
         // BB16 : PROTO_3
         //   SRCLOC: cynw_p2p.h:5074:4
         //    FSM: global_state == 1  && cycle2_state == 0
         always @(posedge clk)
          begin :drive_global_state
            if (rst == 1'b0) begin
               // basic_block:gen_do_stall_reg_full/BB8
               global_state <= 1'b0;
            end
            else begin
               global_state <= 1'b1;
            end
         end

         // rtl_process:fir_logic_1/drive_t_0
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_0
         assign t_0 = ~en_0 & ~cycle1_state & en_1 & global_state;

         // rtl_process:fir_logic_1/drive_t_1
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_1
         assign t_1 = en_0 & global_state;

         // rtl_process:fir_logic_1/drive_t_2
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_2
         assign t_2 = ~cycle1_state & en_1 & global_state;

         // rtl_process:fir_logic_1/drive_t_3
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_3
         assign t_3 = !global_state | cycle1_state | !en_1;

         // rtl_process:fir_logic_1/drive_t_11
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_11
         assign t_11 = ~cycle1_state;

         // rtl_process:fir_logic_1/drive_t_13
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_13
         assign t_13 = ~cycle2_state;

         // rtl_process:fir_logic_1/drive_t_15
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_15
         assign t_15 = ~global_state;

         // rtl_process:fir_logic_1/drive_t_18
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_t_18
         assign t_18 = en_1 & global_state;

         // rtl_process:fir_logic_1/drive_din_busy
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_din_busy
         // at: cynw_p2p.h:1771:13
         assign din_busy = fir_gen_busy_r_1_2_out1[2];

         // rtl_process:fir_logic_1/drive_din_m_data_is_valid
         // Sharing or Control mux
         // Sharing/Controlling 3 operation(s) on drive_din_m_data_is_valid
         // at: cynw_p2p.h:1773:2
         // at: cynw_p2p.h:1824:12
         // at: cynw_p2p.h:1849:21
         assign din_m_data_is_valid = fir_gen_busy_r_1_2_out1[1];

         // rtl_instance:fir_logic_1/fir_gen_busy_r_1_2
         // Resource=fir_gen_busy_r_1, Function=not not and and or or or : Inputs=1,1,1,1 Outputs=3
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1739:8
         assign fir_gen_busy_r_1_2_out1 = {fir_gen_busy_r_1_2_gnew_busy, {fir_gen_busy_r_1_2_gdiv, fir_gen_busy_r_1_2_gen_busy_din_m_data_is_invalid_next}};

         // rtl_instance:fir_logic_1/fir_gen_busy_r_1_2
         // This resource is split across multiple concurrent processes.
         // See line:573

         assign fir_gen_busy_r_1_2_gen_busy_din_m_data_is_invalid_next = ~fir_gen_busy_r_1_2_gdiv;

         // rtl_instance:fir_logic_1/fir_gen_busy_r_1_2
         // This resource is split across multiple concurrent processes.
         // See line:573

         assign fir_gen_busy_r_1_2_gdiv = din_vld & !fir_gen_busy_r_1_2_gnew_req | din_m_stall_reg_full;

         // rtl_instance:fir_logic_1/fir_gen_busy_r_1_2
         // This resource is split across multiple concurrent processes.
         // See line:573

         assign fir_gen_busy_r_1_2_gnew_busy = fir_gen_busy_r_1_2_gnew_req | din_m_stall_reg_full;

         // rtl_instance:fir_logic_1/fir_gen_busy_r_1_2
         // This resource is split across multiple concurrent processes.
         // See line:573

         assign fir_gen_busy_r_1_2_gnew_req = din_m_busy_req_0 & (din_m_unvalidated_req | din_vld);

         // rtl_process:fir_logic_1/drive_din_m_unvalidated_req
         // Sharing or Control mux
         // Sharing/Controlling 4 operation(s) on drive_din_m_unvalidated_req
         // at: cynw_p2p.h:1802:2
         // at: cynw_p2p.h:1796:10
         // at: cynw_p2p.h:1807:13
         // at: cynw_p2p.h:1761:36
         always @(posedge clk)
          begin :drive_din_m_unvalidated_req
            if (rst == 1'b0) begin
               // op:gen_unvalidated_req/OP0
               // at: cynw_p2p.h:1802:2
               // Call Stack: 
               // in function gen_unvalidated_req called from cynw_p2p.h:1802:2
               din_m_unvalidated_req <= 1'd1;
            end
            else begin
               // op:gen_unvalidated_req/OP6
               // at: cynw_p2p.h:1807:13
               // Call Stack: 
               // in function gen_unvalidated_req called from cynw_p2p.h:1807:13
               din_m_unvalidated_req <= fir_N_Muxb_1_2_8_4_1_out1;
            end
         end

         // rtl_instance:fir_logic_1/fir_N_Muxb_1_2_8_4_1
         // Resource=fir_N_Muxb_1_2_8_4, Function=mux : Inputs=1,1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1806:11
         always @(din_m_busy_req_0 or din_vld or din_m_unvalidated_req)
          begin :fir_N_Muxb_1_2_8_4_1
            if (din_m_busy_req_0) begin
               fir_N_Muxb_1_2_8_4_1_out1 = din_m_unvalidated_req;
            end
            else begin
               fir_N_Muxb_1_2_8_4_1_out1 = din_vld;
            end
         end

         // rtl_process:fir_logic_1/drive_din_m_stall_reg
         // Sharing or Control mux
         // Sharing/Controlling 3 operation(s) on drive_din_m_stall_reg
         // at: cynw_p2p.h:1552:10
         // at: cynw_p2p.h:1819:10
         // at: cynw_p2p.h:1828:2
         always @(posedge clk)
          begin :drive_din_m_stall_reg
            case (fir_And_1Ux1U_1U_4_26_out1) 

               1'b1:                begin
                  // op:gen_do_stall_reg/OP191
                  // at: cynw_p2p.h:1828:2
                  // Call Stack: 
                  // in function gen_do_stall_reg called from cynw_p2p.h:1828:2
                  din_m_stall_reg <= din_data;
               end
               
               1'b0:                begin
               end
               
            endcase

         end

         // rtl_instance:fir_logic_1/fir_Not_1U_1U_4_24
         // Resource=fir_Not_1U_1U_4, Function=not : Inputs=1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1824:59
         assign fir_Not_1U_1U_4_24_out1 = !din_m_stall_reg_full;

         // rtl_instance:fir_logic_1/fir_And_1Ux1U_1U_4_25
         // Resource=fir_And_1Ux1U_1U_4, Function=and : Inputs=1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1824:35
         assign fir_And_1Ux1U_1U_4_25_out1 = din_m_data_is_valid & din_m_stalling;

         // rtl_instance:fir_logic_1/fir_And_1Ux1U_1U_4_26
         // Resource=fir_And_1Ux1U_1U_4, Function=and : Inputs=1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1824:56
         assign fir_And_1Ux1U_1U_4_26_out1 = fir_And_1Ux1U_1U_4_25_out1 & fir_Not_1U_1U_4_24_out1;

         // rtl_process:fir_logic_1/drive_din_m_stall_reg_full
         // Sharing or Control mux
         // Sharing/Controlling 5 operation(s) on drive_din_m_stall_reg_full
         // at: cynw_p2p.h:1742:54
         // at: cynw_p2p.h:1551:6
         // at: cynw_p2p.h:1824:60
         // at: cynw_p2p.h:1846:2
         // at: cynw_p2p.h:1849:2
         always @(posedge clk)
          begin :drive_din_m_stall_reg_full
            if (rst == 1'b0) begin
               // op:gen_do_stall_reg_full/OP200
               // at: cynw_p2p.h:1846:2
               // Call Stack: 
               // in function gen_do_stall_reg_full called from cynw_p2p.h:1846:2
               din_m_stall_reg_full <= 1'd0;
            end
            else begin
               // op:gen_do_stall_reg_full/OP204
               // at: cynw_p2p.h:1849:2
               // Call Stack: 
               // in function gen_do_stall_reg_full called from cynw_p2p.h:1849:2
               din_m_stall_reg_full <= fir_And_1Ux1U_1U_4_27_out1;
            end
         end

         // rtl_instance:fir_logic_1/fir_And_1Ux1U_1U_4_27
         // Resource=fir_And_1Ux1U_1U_4, Function=and : Inputs=1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:1849:44
         assign fir_And_1Ux1U_1U_4_27_out1 = din_m_data_is_valid & din_m_stalling;

         // rtl_process:fir_logic_1/drive_dout_vld
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_dout_vld
         // at: cynw_p2p.h:5145:18
         assign dout_vld = fir_Or_1Ux1U_1U_4_5_out1;

         // rtl_instance:fir_logic_1/fir_Or_1Ux1U_1U_4_5
         // Resource=fir_Or_1Ux1U_1U_4, Function=or : Inputs=1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:5145:50
         assign fir_Or_1Ux1U_1U_4_5_out1 = dout_m_unacked_req | fir_Xor_1Ux1U_1U_1_4_out1;

         // rtl_process:fir_logic_1/drive_dout_m_unacked_req
         // Sharing or Control mux
         // Sharing/Controlling 3 operation(s) on drive_dout_m_unacked_req
         // at: cynw_p2p.h:5145:29
         // at: cynw_p2p.h:5157:9
         // at: cynw_p2p.h:5160:9
         always @(posedge clk)
          begin :drive_dout_m_unacked_req
            if (rst == 1'b0) begin
               // op:gen_unacked_req/OP57
               // at: cynw_p2p.h:5157:9
               // Call Stack: 
               // in function gen_unacked_req called from cynw_p2p.h:5157:9
               dout_m_unacked_req <= 1'd0;
            end
            else begin
               // op:gen_unacked_req/OP59
               // at: cynw_p2p.h:5160:9
               // Call Stack: 
               // in function gen_unacked_req called from cynw_p2p.h:5160:9
               dout_m_unacked_req <= fir_And_1Ux1U_1U_1_6_out1;
            end
         end

         // rtl_instance:fir_logic_1/fir_And_1Ux1U_1U_1_6
         // Resource=fir_And_1Ux1U_1U_1, Function=and : Inputs=1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_p2p.h:5172:43
         assign fir_And_1Ux1U_1U_1_6_out1 = dout_busy & dout_vld;

         // rtl_instance:fir_logic_1/fir_Xor_1Ux1U_1U_1_4
         // Resource=fir_Xor_1Ux1U_1U_1, Function=xor : Inputs=1,1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_comm_util.h:1405:70
         assign fir_Xor_1Ux1U_1U_1_4_out1 = dout_m_req_m_trig_req ^ dout_m_req_m_prev_trig_req;

         // rtl_process:fir_logic_1/drive_dout_m_req_m_prev_trig_req
         // Sharing or Control mux
         // Sharing/Controlling 3 operation(s) on drive_dout_m_req_m_prev_trig_req
         // at: cynw_comm_util.h:1418:9
         // at: cynw_comm_util.h:1421:9
         // at: cynw_comm_util.h:1405:73
         always @(posedge clk)
          begin :drive_dout_m_req_m_prev_trig_req
            if (rst == 1'b0) begin
               // op:gen_prev_trig_reg/OP10
               // at: cynw_comm_util.h:1418:9
               // Call Stack: 
               // in function gen_prev_trig_reg called from cynw_comm_util.h:1418:9
               dout_m_req_m_prev_trig_req <= 1'd0;
            end
            else begin
               // op:gen_prev_trig_reg/OP12
               // at: cynw_comm_util.h:1421:9
               // Call Stack: 
               // in function gen_prev_trig_reg called from cynw_comm_util.h:1421:9
               dout_m_req_m_prev_trig_req <= dout_m_req_m_trig_req;
            end
         end

         // rtl_instance:fir_logic_1/fir_Not_1U_1U_1_7
         // Resource=fir_Not_1U_1U_1, Function=not : Inputs=1 Outputs=1
         // Implements 1 operation(s)
         // at: cynw_comm_util.h:1446:25
         assign fir_Not_1U_1U_1_7_out1 = !dout_m_req_m_trig_req;

         // rtl_process:fir_logic_1/drive_dout_data
         // Sharing or Control mux
         // Sharing/Controlling 1 operation(s) on drive_dout_data
         // at: cynw_p2p.h:5279:13
         assign dout_data = {4'b0000, dout_data_slice};


endmodule

