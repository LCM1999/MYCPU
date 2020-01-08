library verilog;
use verilog.vl_types.all;
entity Branch_Control is
    port(
        J               : in     vl_logic_vector(1 downto 0);
        ALUOut          : in     vl_logic;
        Flash           : out    vl_logic;
        PCSrc           : out    vl_logic_vector(1 downto 0)
    );
end Branch_Control;
