library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MB_Debug_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI_input
		C_S00_AXI_input_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_input_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        status_out_0 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
        status_out_1 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
        status_out_2 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
        status_out_3 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI_input
		s00_axi_input_aclk	: in std_logic;
		s00_axi_input_aresetn	: in std_logic;
		s00_axi_input_awaddr	: in std_logic_vector(C_S00_AXI_input_ADDR_WIDTH-1 downto 0);
		s00_axi_input_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_input_awvalid	: in std_logic;
		s00_axi_input_awready	: out std_logic;
		s00_axi_input_wdata	: in std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
		s00_axi_input_wstrb	: in std_logic_vector((C_S00_AXI_input_DATA_WIDTH/8)-1 downto 0);
		s00_axi_input_wvalid	: in std_logic;
		s00_axi_input_wready	: out std_logic;
		s00_axi_input_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_input_bvalid	: out std_logic;
		s00_axi_input_bready	: in std_logic;
		s00_axi_input_araddr	: in std_logic_vector(C_S00_AXI_input_ADDR_WIDTH-1 downto 0);
		s00_axi_input_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_input_arvalid	: in std_logic;
		s00_axi_input_arready	: out std_logic;
		s00_axi_input_rdata	: out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
		s00_axi_input_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_input_rvalid	: out std_logic;
		s00_axi_input_rready	: in std_logic
	);
end MB_Debug_v1_0;

architecture arch_imp of MB_Debug_v1_0 is

	-- component declaration
	component MB_Debug_v1_0_S00_AXI_input is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		STATUS_OUT_0 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
		STATUS_OUT_1 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
		STATUS_OUT_2 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);
		STATUS_OUT_3 : out std_logic_vector(C_S00_AXI_input_DATA_WIDTH-1 downto 0);


		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component MB_Debug_v1_0_S00_AXI_input;

begin

-- Instantiation of Axi Bus Interface S00_AXI_input
MB_Debug_v1_0_S00_AXI_input_inst : MB_Debug_v1_0_S00_AXI_input
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_input_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_input_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s00_axi_input_aclk,
		S_AXI_ARESETN	=> s00_axi_input_aresetn,
		S_AXI_AWADDR	=> s00_axi_input_awaddr,
		S_AXI_AWPROT	=> s00_axi_input_awprot,
		S_AXI_AWVALID	=> s00_axi_input_awvalid,
		S_AXI_AWREADY	=> s00_axi_input_awready,
		S_AXI_WDATA	=> s00_axi_input_wdata,
		S_AXI_WSTRB	=> s00_axi_input_wstrb,
		S_AXI_WVALID	=> s00_axi_input_wvalid,
		S_AXI_WREADY	=> s00_axi_input_wready,
		S_AXI_BRESP	=> s00_axi_input_bresp,
		S_AXI_BVALID	=> s00_axi_input_bvalid,
		S_AXI_BREADY	=> s00_axi_input_bready,
		S_AXI_ARADDR	=> s00_axi_input_araddr,
		S_AXI_ARPROT	=> s00_axi_input_arprot,
		S_AXI_ARVALID	=> s00_axi_input_arvalid,
		S_AXI_ARREADY	=> s00_axi_input_arready,
		S_AXI_RDATA	=> s00_axi_input_rdata,
		S_AXI_RRESP	=> s00_axi_input_rresp,
		S_AXI_RVALID	=> s00_axi_input_rvalid,
		S_AXI_RREADY	=> s00_axi_input_rready,
	    STATUS_OUT_0 => status_out_0,
	    STATUS_OUT_1 => status_out_1,
	    STATUS_OUT_2 => status_out_2,
	    STATUS_OUT_3 => status_out_3
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
