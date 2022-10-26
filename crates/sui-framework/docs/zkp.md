
<a name="0x2_zkp"></a>

# Module `0x2::zkp`



-  [Struct `G1Affine`](#0x2_zkp_G1Affine)
-  [Struct `G2Affine`](#0x2_zkp_G2Affine)
-  [Struct `Proof`](#0x2_zkp_Proof)
-  [Struct `PreparedVerifyingKey`](#0x2_zkp_PreparedVerifyingKey)
-  [Constants](#@Constants_0)
-  [Function `g1_affine_from_bytes`](#0x2_zkp_g1_affine_from_bytes)
-  [Function `g1_affine_to_bytes`](#0x2_zkp_g1_affine_to_bytes)
-  [Function `g2_affine_from_bytes`](#0x2_zkp_g2_affine_from_bytes)
-  [Function `g2_affine_to_bytes`](#0x2_zkp_g2_affine_to_bytes)
-  [Function `vk_gamma_abc_g1_to_vec`](#0x2_zkp_vk_gamma_abc_g1_to_vec)
-  [Function `verify_groth16_proof`](#0x2_zkp_verify_groth16_proof)
-  [Function `internal_verify_groth16_proof`](#0x2_zkp_internal_verify_groth16_proof)


<pre><code></code></pre>



<a name="0x2_zkp_G1Affine"></a>

## Struct `G1Affine`

g1 point in zcash standard


<pre><code><b>struct</b> <a href="zkp.md#0x2_zkp_G1Affine">G1Affine</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>bytes: <a href="">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x2_zkp_G2Affine"></a>

## Struct `G2Affine`

g2 point in zcash standard


<pre><code><b>struct</b> <a href="zkp.md#0x2_zkp_G2Affine">G2Affine</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>bytes: <a href="">vector</a>&lt;u8&gt;</code>
</dt>
<dd>

</dd>
</dl>


</details>

<a name="0x2_zkp_Proof"></a>

## Struct `Proof`

Proof<Bls12_381>


<pre><code><b>struct</b> <a href="zkp.md#0x2_zkp_Proof">Proof</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>a: <a href="zkp.md#0x2_zkp_G1Affine">zkp::G1Affine</a></code>
</dt>
<dd>
 The <code>A</code> element in <code>G1</code>.
</dd>
<dt>
<code>b: <a href="zkp.md#0x2_zkp_G2Affine">zkp::G2Affine</a></code>
</dt>
<dd>
 The <code>B</code> element in <code>G2</code>.
</dd>
<dt>
<code>c: <a href="zkp.md#0x2_zkp_G1Affine">zkp::G1Affine</a></code>
</dt>
<dd>
 The <code>C</code> element in <code>G1</code>.
</dd>
</dl>


</details>

<a name="0x2_zkp_PreparedVerifyingKey"></a>

## Struct `PreparedVerifyingKey`

PreparedVerifyingKey


<pre><code><b>struct</b> <a href="zkp.md#0x2_zkp_PreparedVerifyingKey">PreparedVerifyingKey</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<details>
<summary>Fields</summary>


<dl>
<dt>
<code>vk_gamma_abc_g1: <a href="">vector</a>&lt;<a href="zkp.md#0x2_zkp_G1Affine">zkp::G1Affine</a>&gt;</code>
</dt>
<dd>
 The element vk.gamma_abc_g1,
 aka the <code>[gamma^{-1} * (beta * a_i + alpha * b_i + c_i) * G]</code>, where i spans the public inputs
</dd>
<dt>
<code>alpha_g1_beta_g2: <a href="">vector</a>&lt;u8&gt;</code>
</dt>
<dd>
 The element <code>e(alpha * G, beta * H)</code> in <code>E::GT</code>. blst_fp12
</dd>
<dt>
<code>gamma_g2_neg_pc: <a href="zkp.md#0x2_zkp_G2Affine">zkp::G2Affine</a></code>
</dt>
<dd>
 The element <code>- gamma * H</code> in <code>E::G2</code>, for use in pairings.
</dd>
<dt>
<code>delta_g2_neg_pc: <a href="zkp.md#0x2_zkp_G2Affine">zkp::G2Affine</a></code>
</dt>
<dd>
 The element <code>- delta * H</code> in <code>E::G2</code>, for use in pairings.
</dd>
</dl>


</details>

<a name="@Constants_0"></a>

## Constants


<a name="0x2_zkp_LENGTH"></a>

Length of the vector<u8> representing a SHA3-256 digest.


<pre><code><b>const</b> <a href="zkp.md#0x2_zkp_LENGTH">LENGTH</a>: u64 = 32;
</code></pre>



<a name="0x2_zkp_LengthMismatch"></a>

Error code when the length is invalid.


<pre><code><b>const</b> <a href="zkp.md#0x2_zkp_LengthMismatch">LengthMismatch</a>: u64 = 0;
</code></pre>



<a name="0x2_zkp_g1_affine_from_bytes"></a>

## Function `g1_affine_from_bytes`

Create a Proof with bytes. Aborts if <code>bytes</code> is not of length 32.


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g1_affine_from_bytes">g1_affine_from_bytes</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="zkp.md#0x2_zkp_G1Affine">zkp::G1Affine</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g1_affine_from_bytes">g1_affine_from_bytes</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="zkp.md#0x2_zkp_G1Affine">G1Affine</a> {
    <b>assert</b>!(<a href="_length">vector::length</a>(&bytes) == <a href="zkp.md#0x2_zkp_LENGTH">LENGTH</a>, <a href="zkp.md#0x2_zkp_LengthMismatch">LengthMismatch</a>);
    <a href="zkp.md#0x2_zkp_G1Affine">G1Affine</a> { bytes }
}
</code></pre>



</details>

<a name="0x2_zkp_g1_affine_to_bytes"></a>

## Function `g1_affine_to_bytes`

Get the proof struct.


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g1_affine_to_bytes">g1_affine_to_bytes</a>(self: <a href="zkp.md#0x2_zkp_G1Affine">zkp::G1Affine</a>): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g1_affine_to_bytes">g1_affine_to_bytes</a>(self: <a href="zkp.md#0x2_zkp_G1Affine">G1Affine</a>): <a href="">vector</a>&lt;u8&gt; {
    self.bytes
}
</code></pre>



</details>

<a name="0x2_zkp_g2_affine_from_bytes"></a>

## Function `g2_affine_from_bytes`

Create a Proof with bytes. Aborts if <code>bytes</code> is not of length 32.


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g2_affine_from_bytes">g2_affine_from_bytes</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="zkp.md#0x2_zkp_G2Affine">zkp::G2Affine</a>
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g2_affine_from_bytes">g2_affine_from_bytes</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="zkp.md#0x2_zkp_G2Affine">G2Affine</a> {
    <b>assert</b>!(<a href="_length">vector::length</a>(&bytes) == <a href="zkp.md#0x2_zkp_LENGTH">LENGTH</a>, <a href="zkp.md#0x2_zkp_LengthMismatch">LengthMismatch</a>);
    <a href="zkp.md#0x2_zkp_G2Affine">G2Affine</a> { bytes }
}
</code></pre>



</details>

<a name="0x2_zkp_g2_affine_to_bytes"></a>

## Function `g2_affine_to_bytes`

Get the proof struct.


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g2_affine_to_bytes">g2_affine_to_bytes</a>(self: <a href="zkp.md#0x2_zkp_G2Affine">zkp::G2Affine</a>): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_g2_affine_to_bytes">g2_affine_to_bytes</a>(self: <a href="zkp.md#0x2_zkp_G2Affine">G2Affine</a>): <a href="">vector</a>&lt;u8&gt; {
    self.bytes
}
</code></pre>



</details>

<a name="0x2_zkp_vk_gamma_abc_g1_to_vec"></a>

## Function `vk_gamma_abc_g1_to_vec`




<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_vk_gamma_abc_g1_to_vec">vk_gamma_abc_g1_to_vec</a>(self: <a href="">vector</a>&lt;<a href="zkp.md#0x2_zkp_G1Affine">zkp::G1Affine</a>&gt;): <a href="">vector</a>&lt;<a href="">vector</a>&lt;u8&gt;&gt;
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_vk_gamma_abc_g1_to_vec">vk_gamma_abc_g1_to_vec</a>(self: <a href="">vector</a>&lt;<a href="zkp.md#0x2_zkp_G1Affine">G1Affine</a>&gt;): <a href="">vector</a>&lt;<a href="">vector</a>&lt;u8&gt;&gt; {
    <b>let</b> res = <a href="_empty">vector::empty</a>&lt;<a href="">vector</a>&lt;u8&gt;&gt;();
    <b>let</b> len = <a href="_length">vector::length</a>(&self);
    <b>let</b> i = 0;
    <b>while</b> (i &lt; len) {
        <b>let</b> g1 = <a href="_borrow">vector::borrow</a>(&self, i);
        <b>let</b> bytes = <a href="zkp.md#0x2_zkp_g1_affine_to_bytes">g1_affine_to_bytes</a>(*g1);
        <a href="_push_back">vector::push_back</a>(&<b>mut</b> res, bytes);
        i = i + 1;
    };
    res
}
</code></pre>



</details>

<a name="0x2_zkp_verify_groth16_proof"></a>

## Function `verify_groth16_proof`

@param pvk: PreparedVerifyingKey

@param x

@param proof
Returns the validity of the Groth16 proof passed as argument.


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_verify_groth16_proof">verify_groth16_proof</a>(pvk: <a href="zkp.md#0x2_zkp_PreparedVerifyingKey">zkp::PreparedVerifyingKey</a>, x: <a href="">vector</a>&lt;u8&gt;, proof: &<a href="zkp.md#0x2_zkp_Proof">zkp::Proof</a>): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_verify_groth16_proof">verify_groth16_proof</a>(pvk: <a href="zkp.md#0x2_zkp_PreparedVerifyingKey">PreparedVerifyingKey</a>, x: <a href="">vector</a>&lt;u8&gt;, proof: &<a href="zkp.md#0x2_zkp_Proof">Proof</a>): bool {
    <a href="zkp.md#0x2_zkp_internal_verify_groth16_proof">internal_verify_groth16_proof</a>(
        &<a href="zkp.md#0x2_zkp_vk_gamma_abc_g1_to_vec">vk_gamma_abc_g1_to_vec</a>(pvk.vk_gamma_abc_g1),
        &pvk.alpha_g1_beta_g2,
    &pvk.gamma_g2_neg_pc.bytes,
        &pvk.delta_g2_neg_pc.bytes,
        &x,
        &proof.a.bytes,
    &proof.b.bytes,
        &proof.c.bytes)
}
</code></pre>



</details>

<a name="0x2_zkp_internal_verify_groth16_proof"></a>

## Function `internal_verify_groth16_proof`



<pre><code><b>public</b> <b>fun</b> <a href="zkp.md#0x2_zkp_internal_verify_groth16_proof">internal_verify_groth16_proof</a>(vk_gamma_abc_g1: &<a href="">vector</a>&lt;<a href="">vector</a>&lt;u8&gt;&gt;, alpha_g1_beta_g2: &<a href="">vector</a>&lt;u8&gt;, gamma_g2_neg_pc: &<a href="">vector</a>&lt;u8&gt;, delta_g2_neg_pc: &<a href="">vector</a>&lt;u8&gt;, x: &<a href="">vector</a>&lt;u8&gt;, proof_a: &<a href="">vector</a>&lt;u8&gt;, proof_b: &<a href="">vector</a>&lt;u8&gt;, proof_c: &<a href="">vector</a>&lt;u8&gt;): bool
</code></pre>



<details>
<summary>Implementation</summary>


<pre><code><b>public</b> <b>native</b> <b>fun</b> <a href="zkp.md#0x2_zkp_internal_verify_groth16_proof">internal_verify_groth16_proof</a>(vk_gamma_abc_g1: &<a href="">vector</a>&lt;<a href="">vector</a>&lt;u8&gt;&gt;,
    alpha_g1_beta_g2: &<a href="">vector</a>&lt;u8&gt;, gamma_g2_neg_pc: &<a href="">vector</a>&lt;u8&gt;, delta_g2_neg_pc: &<a href="">vector</a>&lt;u8&gt;, x: &<a href="">vector</a>&lt;u8&gt;, proof_a: &<a href="">vector</a>&lt;u8&gt;, proof_b: &<a href="">vector</a>&lt;u8&gt;, proof_c: &<a href="">vector</a>&lt;u8&gt;): bool;
</code></pre>



</details>
