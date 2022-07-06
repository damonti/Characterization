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
//`define DATAW           66                  
//`define DATAW_P1        67        
`define DATAW           34                  
`define DATAW_P1        35          
`define DST_LSB         0                   
`define DST_MSB         3                  
`define SRC_LSB         4                  
`define SRC_MSB         7                  
`define VCH_LSB         8                  
`define VCH_MSB         11                  
`define TYPE_LSB        32                  
`define TYPE_MSB        34                  

/* Flit type */                 
`define TYPEW           2       
`define TYPEW_P1        3       
`define TYPE_NONE       3'b000  
`define TYPE_HEAD       3'b001  
`define TYPE_TAIL       3'b010  
`define TYPE_HEADTAIL   3'b011  
`define TYPE_DATA       3'b100  

/* Input FIFO (4-element) */ 
`define FIFO            7 
`define FIFO_P1         8 
`define FIFOD           2 
`define FIFOD_P1        3 
`define PKTLEN          7 
`define PKTLEN_P1       8 

/* Port number (3-port) */        
`define PORT            2         
`define PORT_P1         3         
`define PORTW           1         
`define PORTW_P1        2         

/* Vch number (2-VC) */   
`define VCH             1 
`define VCH_P1          2 
`define VCHW            0 
`define VCHW_P1         1 

/* Node number (16-node) */        
`define NODE            15         
`define NODE_P1         16         
`define NODEW           3         
`define NODEW_P1        4         

/* Dimenion-order routing */
`define ENTRYW          3         
`define ENTRYW_P1       4         
`define ARRAYW          3         
`define ARRAYW_P1       4         
`define DSTX_LSB        0          
`define DSTX_MSB        3         
`define DSTY_LSB        4         
`define DSTY_MSB        7         
`define ARRAY_DIV2      8         

