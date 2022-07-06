/* Common definitions */           
`define Enable          1'b1       
`define Disable         1'b0       
`define Enable_         1'b0       
`define Disable_        1'b1       
`define High            1'b1       
`define Low             1'b0       
`define Write           1'b1       
`define Read            1'b0       
`define NULL            0          

/* Data width (64-bit data + 3-bit type) */ 
`define DATAW           66                  
`define DATAW_P1        67                  
`define DST_LSB         0                   
`define DST_MSB         3                  
`define SRC_LSB         4                  
`define SRC_MSB         7                  
`define VCH_LSB         8                  
`define VCH_MSB         11                  
`define TYPE_LSB        64                  
`define TYPE_MSB        66                  

/* Flit type */                 
`define TYPEW           2       
`define TYPEW_P1        3       
`define TYPE_NONE       3'b000  
`define TYPE_HEAD       3'b001  
`define TYPE_TAIL       3'b010  
`define TYPE_HEADTAIL   3'b011  
`define TYPE_DATA       3'b100  

/* Input FIFO (4-element) */ 
`define FIFO            15 
`define FIFO_P1         16 
`define FIFOD           3 
`define FIFOD_P1        4 
`define PKTLEN          15 
`define PKTLEN_P1       16 

/* Port number (5-port) */        
`define PORT            2         
`define PORT_P1         3         
`define PORTW           2         
`define PORTW_P1        3         

/* Vch number (4-VC) */   
`define VCH             3 
`define VCH_P1          4 
`define VCHW            1 
`define VCHW_P1         2 

/* Node number (16-node) */        
`define NODE            15         
`define NODE_P1         16         
`define NODEW           3         
`define NODEW_P1        4         

/* Dimenion-order routing */
`define ENTRYW          3         
`define ENTRYW_P1       4         
`define ARRAYW          1         
`define ARRAYW_P1       2         
`define DSTX_LSB        0          
`define DSTX_MSB        1         
`define DSTY_LSB        2         
`define DSTY_MSB        3         
`define ARRAY_DIV2      2         

