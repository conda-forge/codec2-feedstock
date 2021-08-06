#!/usr/bin/env bash

set -ex

cd build/src

cmd_list=(
    c2enc
    c2dec
    c2sim
    cohpsk_ch
    cohpsk_demod
    cohpsk_get_test_bits
    cohpsk_mod
    cohpsk_put_test_bits
    deframer
    fdmdv_channel
    fdmdv_demod
    fdmdv_get_test_bits
    fdmdv_mod
    fdmdv_put_test_bits
    fm_demod
    fmfsk_demod
    fmfsk_mod
    framer
    freedv_data_raw_rx
    freedv_data_raw_tx
    freedv_data_rx
    freedv_data_tx
    freedv_mixed_rx
    freedv_mixed_tx
    freedv_rx
    freedv_tx
    fsk_demod
    fsk_get_test_bits
    fsk_mod
    fsk_mod_ext_vco
    fsk_put_test_bits
    insert_errors
    ldpc_dec
    ldpc_enc
    ldpc_noise
    ofdm_demod
    ofdm_get_test_bits
    ofdm_mod
    ofdm_put_test_bits
    tollr
    vhf_deframe_c2
    vhf_frame_c2
)

cp "${cmd_list[@]}" "$PREFIX/bin"
