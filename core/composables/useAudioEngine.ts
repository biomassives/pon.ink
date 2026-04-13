// WEB AUDIO ENGINE: Moog / Sampler / Recording
// Tonight's Logic: Initialize AudioContext and Oscillator/Buffer connections.
import { ref } from 'vue';

export const useAudioEngine = () => {
  const audioCtx = ref<AudioContext | null>(null);
  const masterGain = ref<GainNode | null>(null);

  const initEngine = () => {
    audioCtx.value = new (window.AudioContext || (window as any).webkitAudioContext)();
    masterGain.value = audioCtx.value.createGain();
    masterGain.value.connect(audioCtx.value.destination);
    console.log("Audio Engine Inked: [READY]");
  };

  // Stub for Moog-style Synth
  const playMoogNote = (freq: number) => {
    if (!audioCtx.value || !masterGain.value) return;
    const osc = audioCtx.value.createOscillator();
    osc.type = 'sawtooth'; // Classic Moog vibe
    osc.frequency.setValueAtTime(freq, audioCtx.value.currentTime);
    osc.connect(masterGain.value);
    osc.start();
    osc.stop(audioCtx.value.currentTime + 0.5);
  };

  return { initEngine, playMoogNote, audioCtx, masterGain };
};
