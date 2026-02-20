return {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    cmd = {
        "MoltenInit",
        "MoltenEvaluateOperator",
        "MoltenEvaluateLine",
        "MoltenEvaluateVisual",
        "MoltenReevaluateCell",
        "MoltenDelete",
        "MoltenHideOutput",
        "MoltenShowOutput",
        "MoltenInfo",
    },
    ft = { "python" },
    init = function()
        vim.g.molten_output_win_max_height = 12
    end,
}
