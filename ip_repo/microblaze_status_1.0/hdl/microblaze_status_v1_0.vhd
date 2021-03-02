library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microblaze_status_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Master Bus Interface status_stream
		C_status_stream_TDATA_WIDTH	: integer	:= 32;
		C_status_stream_START_COUNT	: integer	:= 32
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Master Bus Interface status_stream
		status_stream_aclk	: in std_logic;
		status_stream_aresetn	: in std_logic;
		status_stream_tvalid	: out std_logic;
		status_stream_tdata	: out std_logic_vector(C_status_stream_TDATA_WIDTH-1 downto 0);
		status_stream_tstrb	: out std_logic_vector((C_status_stream_TDATA_WIDTH/8)-1 downto 0);
		status_stream_tlast	: out std_logic;
		status_stream_tready	: in std_logic
	);
end microblaze_status_v1_0;

architecture arch_imp of microblaze_status_v1_0 is

	-- component declaration
	component microblaze_status_v1_0_status_stream is
		generic (
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M_START_COUNT	: integer	:= 32
		);
		port (
		M_AXIS_ACLK	: in std_logic;
		M_AXIS_ARESETN	: in std_logic;
		M_AXIS_TVALID	: out std_logic;
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
		M_AXIS_TLAST	: out std_logic;
		M_AXIS_TREADY	: in std_logic
		);
	end component microblaze_status_v1_0_status_stream;

begin

-- Instantiation of Axi Bus Interface status_stream
microblaze_status_v1_0_status_stream_inst : microblaze_status_v1_0_status_stream
	generic map (
		C_M_AXIS_TDATA_WIDTH	=> C_status_stream_TDATA_WIDTH,
		C_M_START_COUNT	=> C_status_stream_START_COUNT
	)
	port map (
		M_AXIS_ACLK	=> status_stream_aclk,
		M_AXIS_ARESETN	=> status_stream_aresetn,
		M_AXIS_TVALID	=> status_stream_tvalid,
		M_AXIS_TDATA	=> status_stream_tdata,
		M_AXIS_TSTRB	=> status_stream_tstrb,
		M_AXIS_TLAST	=> status_stream_tlast,
		M_AXIS_TREADY	=> status_stream_tready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
