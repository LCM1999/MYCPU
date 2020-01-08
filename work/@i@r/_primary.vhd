library verilog;
use verilog.vl_types.all;
entity IR is
    port(
        CLK             : in     vl_logic;
        ins             : in     vl_logic_vector(31 downto 0);
        IRIns           : out    vl_logic_vector(31 downto 0)
    );
end IR;
