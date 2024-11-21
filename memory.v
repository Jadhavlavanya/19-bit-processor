module Memory (
    input clk,                      // Clock signal
    input [18:0] address,           // Memory address
    input [18:0] dataIn,            // Data to be written
    input memWrite,                 // Write enable
    input memRead,                  // Read enable
    output reg [18:0] dataOut       // Data output
);
  reg [18:0] memory [0:511];
    always @(posedge clk) begin
        if (memWrite) memory[address] = dataIn;   // Write data to memory
        if (memRead) dataOut = memory[address];   // Read data from memory
    end
endmodule

//testbench
module Memory_tb;
    reg clk;
    reg [18:0] address, dataIn;
    reg memWrite, memRead;
    wire [18:0] dataOut;
    Memory uut (
      .clk(clk), .address(address),.dataIn(dataIn),.memWrite(memWrite),.memRead(memRead), .dataOut(dataOut));
    always #5 clk = ~clk;
    initial begin
        clk = 0;
  address = 19'd0;
        dataIn = 19'd123;
        memWrite = 0; memRead = 0;
     // case1:write data to memory
      memWrite = 1;address = 19'd0; #10; 
        memWrite = 0;
      //case2:read data from memory
        memRead = 1;
        #10; 
        $display("Read Data: %d (Expected: 123)", dataOut);
        // Test case 3: write new data to another address
        memWrite = 1; address = 19'd1; dataIn = 19'd456;
        #10
        memWrite = 0;
 // Test case 4: Read new data from memory
        memRead = 1;
        #10;
        $display("Read Data: %d (Expected: 456)", dataOut);
        $finish;
    end
endmodule



