return {
	{
		"stevearc/vim-arduino",
		lazy = true,
		ft = "arduino",
		keys = {
			{ "<leader>aa", "<CMD>ArduinoAttach<CR>" },
			{ "<leader>av", "<CMD>ArduinoVerify<CR>" },
			{ "<leader>au", "<CMD>ArduinoUpload<CR>" },
			{ "<leader>aU", "<CMD>ArduinoUploadAndSerial<CR>" },
			{ "<leader>as", "<CMD>ArduinoSerial<CR>" },
			{ "<leader>ab", "<CMD>ArduinoChooseBoard<CR>" },
			{ "<leader>ap", "<CMD>ArduinoChoosePort<CR>" },
			{ "<leader>aP", "<CMD>ArduinoChooseProgrammer<CR>" },
			{ "<leader>ai", "<CMD>ArduinoInfo<CR>" },
		},
	},
}
