// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module sui::zkp {
    use std::vector;

    /// Length of the vector<u8> representing a SHA3-256 digest.
    const LENGTH: u64 = 32;

    /// Error code when the length is invalid.
    const LengthMismatch: u64 = 0;

    /// g1 point in zcash standard
    struct G1Affine has store, copy, drop {
        bytes: vector<u8>,
    }

    /// g2 point in zcash standard
    struct G2Affine has store, copy, drop {
        bytes: vector<u8>,
    }

    /// Proof<Bls12_381>
    struct Proof has store, copy, drop {
        /// The `A` element in `G1`.
        a: G1Affine,
        /// The `B` element in `G2`.
        b: G2Affine,
        /// The `C` element in `G1`.
        c: G1Affine,
    }

    /// PreparedVerifyingKey
    struct PreparedVerifyingKey has store, copy, drop {
        /// The element vk.gamma_abc_g1,
        /// aka the `[gamma^{-1} * (beta * a_i + alpha * b_i + c_i) * G]`, where i spans the public inputs
        vk_gamma_abc_g1: vector<G1Affine>,
        /// The element `e(alpha * G, beta * H)` in `E::GT`. blst_fp12
        alpha_g1_beta_g2: vector<u8>,
        /// The element `- gamma * H` in `E::G2`, for use in pairings.
        gamma_g2_neg_pc: G2Affine,
        /// The element `- delta * H` in `E::G2`, for use in pairings.
        delta_g2_neg_pc: G2Affine,
    }

    /// Create a Proof with bytes. Aborts if `bytes` is not of length 32.
    public fun g1_affine_from_bytes(bytes: vector<u8>): G1Affine {
        assert!(vector::length(&bytes) == LENGTH, LengthMismatch);
        G1Affine { bytes }
    }

    /// Get the proof struct.
    public fun g1_affine_to_bytes(self: G1Affine): vector<u8> {
        self.bytes
    }

    /// Create a Proof with bytes. Aborts if `bytes` is not of length 32.
    public fun g2_affine_from_bytes(bytes: vector<u8>): G2Affine {
        assert!(vector::length(&bytes) == LENGTH, LengthMismatch);
        G2Affine { bytes }
    }

    /// Get the proof struct.
    public fun g2_affine_to_bytes(self: G2Affine): vector<u8> {
        self.bytes
    }

    /// 
    public fun vk_gamma_abc_g1_to_vec(self: vector<G1Affine>): vector<vector<u8>> {
        let res = vector::empty<vector<u8>>();
        let len = vector::length(&self);
        let i = 0;
        while (i < len) {
            let g1 = vector::borrow(&self, i);
            let bytes = g1_affine_to_bytes(*g1);
            vector::push_back(&mut res, bytes);
            i = i + 1;
        };
        res
    }
    /// @param pvk: PreparedVerifyingKey
    ///
    /// @param x
    ///
    /// @param proof
    /// Returns the validity of the Groth16 proof passed as argument.
    public fun verify_groth16_proof(pvk: PreparedVerifyingKey, x: vector<u8>, proof: &Proof): bool {
        internal_verify_groth16_proof(
            &vk_gamma_abc_g1_to_vec(pvk.vk_gamma_abc_g1), 
            &pvk.alpha_g1_beta_g2, 
        &pvk.gamma_g2_neg_pc.bytes, 
            &pvk.delta_g2_neg_pc.bytes, 
            &x, 
            &proof.a.bytes, 
        &proof.b.bytes, 
            &proof.c.bytes)
    }

    public native fun internal_verify_groth16_proof(vk_gamma_abc_g1: &vector<vector<u8>>, 
        alpha_g1_beta_g2: &vector<u8>, gamma_g2_neg_pc: &vector<u8>, delta_g2_neg_pc: &vector<u8>, x: &vector<u8>, proof_a: &vector<u8>, proof_b: &vector<u8>, proof_c: &vector<u8>): bool;
}
