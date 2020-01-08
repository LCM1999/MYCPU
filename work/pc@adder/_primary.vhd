library verilog;
use verilog.vl_types.all;
entity pcAdder is
    port(
        RST             : in     vl_logic;
        PCSrc           : in     vl_logic_vector(1 downto 0);
        offset          : in     vl_logic_vector(31 downto 0);
        currPC          : in     vl_logic_vector(31 downto 0);
        nextPC          : out    vl_logic_vector(31 downto 0)
    );
end pcAdder;
