export const idlFactory = ({ IDL }) => {
  const Tree = IDL.Rec();
  const Tree_1 = IDL.Rec();
  const AutoScalingCanisterSharedFunctionHook = IDL.Func(
      [IDL.Text],
      [IDL.Text],
      [],
    );
  const ScalingLimitType = IDL.Variant({
    'heapSize' : IDL.Nat,
    'count' : IDL.Nat,
  });
  const ScalingOptions = IDL.Record({
    'autoScalingHook' : AutoScalingCanisterSharedFunctionHook,
    'sizeLimit' : ScalingLimitType,
  });
  const PK = IDL.Text;
  const SK = IDL.Text;
  const Color = IDL.Variant({ 'B' : IDL.Null, 'R' : IDL.Null });
  const AttributeKey = IDL.Text;
  const AttributeValuePrimitive = IDL.Variant({
    'int' : IDL.Int,
    'float' : IDL.Float64,
    'bool' : IDL.Bool,
    'text' : IDL.Text,
  });
  const AttributeValueRBTreeValue = IDL.Variant({
    'int' : IDL.Int,
    'float' : IDL.Float64,
    'tuple' : IDL.Vec(AttributeValuePrimitive),
    'blob' : IDL.Vec(IDL.Nat8),
    'bool' : IDL.Bool,
    'text' : IDL.Text,
    'arrayBool' : IDL.Vec(IDL.Bool),
    'arrayText' : IDL.Vec(IDL.Text),
    'arrayInt' : IDL.Vec(IDL.Int),
    'arrayFloat' : IDL.Vec(IDL.Float64),
  });
  Tree_1.fill(
    IDL.Variant({
      'leaf' : IDL.Null,
      'node' : IDL.Tuple(
        Color,
        Tree_1,
        IDL.Tuple(IDL.Text, IDL.Opt(AttributeValueRBTreeValue)),
        Tree_1,
      ),
    })
  );
  const AttributeValue = IDL.Variant({
    'int' : IDL.Int,
    'float' : IDL.Float64,
    'tuple' : IDL.Vec(AttributeValuePrimitive),
    'blob' : IDL.Vec(IDL.Nat8),
    'bool' : IDL.Bool,
    'text' : IDL.Text,
    'tree' : Tree_1,
    'arrayBool' : IDL.Vec(IDL.Bool),
    'arrayText' : IDL.Vec(IDL.Text),
    'arrayInt' : IDL.Vec(IDL.Int),
    'arrayFloat' : IDL.Vec(IDL.Float64),
  });
  Tree.fill(
    IDL.Variant({
      'leaf' : IDL.Null,
      'node' : IDL.Tuple(
        Color,
        Tree,
        IDL.Tuple(AttributeKey, IDL.Opt(AttributeValue)),
        Tree,
      ),
    })
  );
  const AttributeMap = IDL.Variant({
    'leaf' : IDL.Null,
    'node' : IDL.Tuple(
      Color,
      Tree,
      IDL.Tuple(AttributeKey, IDL.Opt(AttributeValue)),
      Tree,
    ),
  });
  const Entity = IDL.Record({
    'pk' : PK,
    'sk' : SK,
    'attributes' : AttributeMap,
  });
  const AppType = IDL.Variant({
    'dao' : IDL.Null,
    'communication' : IDL.Null,
    'wip' : IDL.Null,
    'portfolio' : IDL.Null,
    'funny' : IDL.Null,
    'interesting' : IDL.Null,
    'music' : IDL.Null,
    'utility' : IDL.Null,
    'social' : IDL.Null,
    'video' : IDL.Null,
    'learning' : IDL.Null,
    'blog' : IDL.Null,
    'defi' : IDL.Null,
    'docs' : IDL.Null,
    'info' : IDL.Null,
    'news' : IDL.Null,
    'scam' : IDL.Null,
    'landing' : IDL.Null,
    'investor' : IDL.Null,
  });
  const SubnetId = IDL.Variant({
    'subnetId__yinp6_35cfo_wgcd2_oc4ty_2kqpf_t4dul_rfk33_fsq3r_mfmua_m2ngh_jqe' : IDL.Null,
    'subnetId__snjp4_xlbw4_mnbog_ddwy6_6ckfd_2w5a2_eipqo_7l436_pxqkh_l6fuv_vae' : IDL.Null,
    'subnetId__w4asl_4nmyj_qnr7c_6cqq4_tkwmt_o26di_iupkq_vx4kt_asbrx_jzuxh_4ae' : IDL.Null,
    'subnetId__eq6en_6jqla_fbu5s_daskr_h6hx2_376n5_iqabl_qgrng_gfqmv_n3yjr_mqe' : IDL.Null,
    'subnetId__mpubz_g52jc_grhjo_5oze5_qcj74_sex34_omprz_ivnsm_qvvhr_rfzpv_vae' : IDL.Null,
    'subnetId__o3ow2_2ipam_6fcjo_3j5vt_fzbge_2g7my_5fz2m_p4o2t_dwlc4_gt2q7_5ae' : IDL.Null,
    'subnetId__lspz2_jx4pu_k3e7p_znm7j_q4yum_ork6e_6w4q6_pijwq_znehu_4jabe_kqe' : IDL.Null,
    'subnetId__qxesv_zoxpm_vc64m_zxguk_5sj74_35vrb_tbgwg_pcird_5gr26_62oxl_cae' : IDL.Null,
    'subnetId__shefu_t3kr5_t5q3w_mqmdq_jabyv_vyvtf_cyyey_3kmo4_toyln_emubw_4qe' : IDL.Null,
    'subnetId__4ecnw_byqwz_dtgss_ua2mh_pfvs7_c3lct_gtf4e_hnu75_j7eek_iifqm_sqe' : IDL.Null,
    'subnetId__5kdm2_62fc6_fwnja_hutkz_ycsnm_4z33i_woh43_4cenu_ev7mi_gii6t_4ae' : IDL.Null,
    'subnetId__io67a_2jmkw_zup3h_snbwi_g6a5n_rm5dn_b6png_lvdpl_nqnto_yih6l_gqe' : IDL.Null,
    'subnetId__3hhby_wmtmw_umt4t_7ieyg_bbiig_xiylg_sblrt_voxgt_bqckd_a75bf_rqe' : IDL.Null,
    'subnetId__k44fs_gm4pv_afozh_rs7zw_cg32n_u7xov_xqyx3_2pw5q_eucnu_cosd4_uqe' : IDL.Null,
    'subnetId__6pbhf_qzpdk_kuqbr_pklfa_5ehhf_jfjps_zsj6q_57nrl_kzhpd_mu7hc_vae' : IDL.Null,
    'subnetId__4zbus_z2bmt_ilreg_xakz4_6tyre_hsqj4_slb4g_zjwqo_snjcc_iqphi_3qe' : IDL.Null,
    'subnetId__brlsh_zidhj_3yy3e_6vqbz_7xnih_xeq2l_as5oc_g32c4_i5pdn_2wwof_oae' : IDL.Null,
    'subnetId__nl6hn_ja4yw_wvmpy_3z2jx_ymc34_pisx3_3cp5z_3oj4a_qzzny_jbsv3_4qe' : IDL.Null,
    'subnetId__jtdsg_3h6gi_hs7o5_z2soi_43w3z_soyl3_ajnp3_ekni5_sw553_5kw67_nqe' : IDL.Null,
    'subnetId__pae4o_o6dxf_xki7q_ezclx_znyd6_fnk6w_vkv5z_5lfwh_xym2i_otrrw_fqe' : IDL.Null,
    'subnetId__cv73p_6v7zi_u67oy_7jc3h_qspsz_g5lrj_4fn7k_xrax3_thek2_sl46v_jae' : IDL.Null,
    'subnetId__ejbmu_grnam_gk6ol_6irwa_htwoj_7ihfl_goimw_hlnvh_abms4_47v2e_zqe' : IDL.Null,
    'subnetId__lhg73_sax6z_2zank_6oer2_575lz_zgbxx_ptudx_5korm_fy7we_kh4hl_pqe' : IDL.Null,
    'subnetId__e66qm_3cydn_nkf4i_ml4rb_4ro6o_srm5s_x5hwq_hnprz_3meqp_s7vks_5qe' : IDL.Null,
    'subnetId__csyj4_zmann_ys6ge_3kzi6_onexi_obayx_2fvak_zersm_euci4_6pslt_lae' : IDL.Null,
    'subnetId__opn46_zyspe_hhmyp_4zu6u_7sbrh_dok77_m7dch_im62f_vyimr_a3n2c_4ae' : IDL.Null,
    'subnetId__qdvhd_os4o2_zzrdw_xrcv4_gljou_eztdp_bj326_e6jgr_tkhuc_ql6v2_yqe' : IDL.Null,
    'subnetId__gmq5v_hbozq_uui6y_o55wc_ihop3_562wb_3qspg_nnijg_npqp5_he3cj_3ae' : IDL.Null,
    'subnetId__pjljw_kztyl_46ud4_ofrj6_nzkhm_3n4nt_wi3jt_ypmav_ijqkt_gjf66_uae' : IDL.Null,
  });
  const PostRequest = IDL.Record({
    'title' : IDL.Text,
    'content' : IDL.Text,
    'note' : IDL.Text,
    'apptype' : AppType,
    'datalength' : IDL.Nat,
    'subnetid' : SubnetId,
    'subtitle' : IDL.Text,
    'canisterid' : IDL.Text,
  });
  const Service = IDL.Service({
    'categorySearchNewest' : IDL.Func(
        [IDL.Text, IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'debug_searchBySk' : IDL.Func([IDL.Text], [IDL.Opt(Entity)], ['query']),
    'debug_show_all' : IDL.Func([], [IDL.Text], ['query']),
    'getNextKeysForParallelSearchTerm' : IDL.Func(
        [],
        [IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'getOwners' : IDL.Func([], [IDL.Opt(IDL.Vec(IDL.Text))], ['query']),
    'getPK' : IDL.Func([], [IDL.Text], ['query']),
    'isStatusComplete' : IDL.Func([], [IDL.Bool], ['query']),
    'reportBroken' : IDL.Func([IDL.Text], [], []),
    'searchCanisterId' : IDL.Func([IDL.Text], [IDL.Text], ['query']),
    'searchCategory' : IDL.Func(
        [IDL.Text, IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'searchTerm' : IDL.Func(
        [IDL.Text, IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'searchTermForParallel' : IDL.Func(
        [IDL.Vec(IDL.Text)],
        [IDL.Text, IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'searchTermWithNextKeysForParallelSearch' : IDL.Func(
        [IDL.Text],
        [IDL.Text, IDL.Vec(IDL.Text)],
        ['query'],
      ),
    'searchTermWithTarget' : IDL.Func(
        [IDL.Bool, IDL.Bool, IDL.Bool, IDL.Vec(IDL.Text), IDL.Opt(IDL.Text)],
        [IDL.Text, IDL.Opt(IDL.Text)],
        ['query'],
      ),
    'skExists' : IDL.Func([IDL.Text], [IDL.Bool], ['query']),
    'transferCycles' : IDL.Func([], [], []),
    'upload' : IDL.Func([IDL.Text], [], []),
    'userNewPost' : IDL.Func([PostRequest], [], []),
  });
  return Service;
};
export const init = ({ IDL }) => {
  const AutoScalingCanisterSharedFunctionHook = IDL.Func(
      [IDL.Text],
      [IDL.Text],
      [],
    );
  const ScalingLimitType = IDL.Variant({
    'heapSize' : IDL.Nat,
    'count' : IDL.Nat,
  });
  const ScalingOptions = IDL.Record({
    'autoScalingHook' : AutoScalingCanisterSharedFunctionHook,
    'sizeLimit' : ScalingLimitType,
  });
  return [
    IDL.Record({
      'owners' : IDL.Opt(IDL.Vec(IDL.Principal)),
      'partitionKey' : IDL.Text,
      'scalingOptions' : ScalingOptions,
    }),
  ];
};
