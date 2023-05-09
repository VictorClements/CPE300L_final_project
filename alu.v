module alu (a,b,sel, out, zero);
    input [31:0] a,b;
    input [2:0] sel; 
    output reg [31:0] out;
 output reg zero;
  
  initial
  begin
  out = 0;
  zero =1'b0;
  end
    always @ (*) 
    begin 
        case(sel) 
            3'b000: 
			begin
				out=a & b; 
				if (out == 0)
				zero = 1;  
				else
				zero = 0;
			end                   
            3'b001:
			begin
				out= a | b; 
				if (out == 0)
				zero = 1;  
				else
				zero = 0; 
			end		
            3'b110: 
			begin
				out=a-b;  
				if (out == 0)
				zero = 1;  
				else
				zero = 0;
          	end        
        	3'b010: 
			begin
				out=a+b;  
				if (out == 0)
				zero = 1;  
				else
				zero = 0;
			end         
            3'b111: 
           	begin
				if ( a < b)
				begin
				out = 1;
				zero = 0;
				end
				else
				begin
				out=0;
				zero = 0;
				end
          	end 
			3'b100:
			begin
				out = b << a;
				if(out == 0)
				zero = 1;
				else
				zero = 0;
			end
			3'b101:
			begin
				out = b >> a;
				if(out == 0)
				zero = 1;
				else
				zero = 0;
			end
			default:
			begin
			out = 32'b0;
			zero = 0;
		   end		
		endcase
	end
endmodule