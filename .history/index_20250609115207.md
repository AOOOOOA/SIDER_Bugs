---
layout: default
title: Experiment Results
---

# Experiment Results

Below is a summary table of our main experiment findings.

<table>
    <thead>
        <tr>
            <th>Simulator</th>
            <th>Bugs Found</th>
            <th>Critical Issues</th>
            <th>Confirmed by Devs</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>CARLA</td>
            <td>13</td>
            <td>Collisions, Off-road, Stuck</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>MetaDrive</td>
            <td>5</td>
            <td>Collision, Off-road, Stuck</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>CARLA-Apollo</td>
            <td>3</td>
            <td>Stuck, Trajectory Deviations</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

---

## Introduction

3D driving simulators are essential tools for autonomous driving research. However, their reliability is often overlooked.  
Our project systematically evaluates simulator reliability and exposes several critical bugs.

## Key Findings

- **20 distinct simulator bugs** found across three major simulators.
- **Critical failures** include collisions, off-road events, agent stuck, and trajectory deviations.
- Some bugs have been **confirmed by original developers**.
- Certain errors **do not occur in matched real-world experiments**, showing risk of misleading ADS evaluation.

## Detailed Results

<div style="display: flex; justify-content: space-around; align-items: flex-start; gap: 20px; margin: 20px 0;">
    <div style="flex: 1; text-align: center;">
        <h4>Simulator Video</h4>
        <video width="100%" height="auto" controls style="max-width: 400px;">
            <source src="assets/sandbox_simulator.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        <p><em>Scenario in simulator</em></p>
    </div>
    <div style="flex: 1; text-align: center;">
        <h4>Reality Video</h4>
        <video width="100%" height="auto" controls style="max-width: 400px;">
            <source src="assets/sandbox_reality.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        <p><em>Corresponding real-world scenario</em></p>
    </div>
</div>


---

## Contact

Feel free to contact us on github repo for more information.
