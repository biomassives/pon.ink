// FIGURE-STYLE ENGINE: Constrained Rhythm & Harmony
// Tributing Propellerhead: X/Y Pad Logic for 440Hz Harmonics & Boom Bap
import { ref } from 'vue';
import { useAudioEngine } from './useAudioEngine';

export const useFigureEngine = () => {
  const { audioCtx, masterGain } = useAudioEngine();

  // 1. HARMONIC SYNTH (440Hz Base)
  const playHarmonic = (ratio: number, volume: number) => {
    if (!audioCtx.value || !masterGain.value) return;
    const osc = audioCtx.value.createOscillator();
    const g = audioCtx.value.createGain();
    
    osc.type = 'triangle';
    osc.frequency.setValueAtTime(440 * ratio, audioCtx.value.currentTime);
    
    g.gain.setValueAtTime(volume, audioCtx.value.currentTime);
    g.gain.exponentialRampToValueAtTime(0.001, audioCtx.value.currentTime + 0.5);
    
    osc.connect(g).connect(masterGain.value);
    osc.start();
    osc.stop(audioCtx.value.currentTime + 0.5);
  };

  // 2. BOOM BAP KICK SYNTH (Procedural)
  const playBoomBapKick = () => {
    if (!audioCtx.value || !masterGain.value) return;
    const osc = audioCtx.value.createOscillator();
    const g = audioCtx.value.createGain();
    
    osc.frequency.setValueAtTime(150, audioCtx.value.currentTime);
    osc.frequency.exponentialRampToValueAtTime(0.01, audioCtx.value.currentTime + 0.5);
    
    g.gain.setValueAtTime(1, audioCtx.value.currentTime);
    g.gain.exponentialRampToValueAtTime(0.01, audioCtx.value.currentTime + 0.5);
    
    osc.connect(g).connect(masterGain.value);
    osc.start();
    osc.stop(audioCtx.value.currentTime + 0.5);
  };

  return { playHarmonic, playBoomBapKick };
};
