<script setup>
</script>

<template>
    <div>
        <section id="about" class="about-section">
            <div class="container-fluid px-0">
                <div class="about-hero-section">
                    <div class="container custom-container">
                        <div class="row align-items-center g-5">
                            <div class="col-lg-6 col-md-12">
                                <div class="text-content">
                                    <div class="badge-container mb-4">
                                        <span class="about-badge">About Us</span>
                                    </div>
                                    <h1 class="hero-title">
                                        Welcome to the Bulan 
                                        <span class="gradient-text">Lost and Found</span> 
                                        Website!
                                    </h1>
                                    <p class="hero-subtitle">
                                        This platform was created to help the people
                                        of Bulan reconnect with their lost items and
                                        recover valuables. Our goal is to make it
                                        easier for individuals to report lost or
                                        found items and promote a more connected,
                                        responsible community.
                                    </p>
                                    <div class="feature-grid mt-5">
                                        <div class="feature-item">
                                            <div class="feature-icon">
                                                <i class="bi bi-search"></i>
                                            </div>
                                            <div class="feature-text">
                                                <h6>Easy Search</h6>
                                                <p>Find items quickly</p>
                                            </div>
                                        </div>
                                        <div class="feature-item">
                                            <div class="feature-icon">
                                                <i class="bi bi-chat-dots"></i>
                                            </div>
                                            <div class="feature-text">
                                                <h6>Community Driven</h6>
                                                <p>Help each other</p>
                                            </div>
                                        </div>
                                        <div class="feature-item">
                                            <div class="feature-icon">
                                                <i class="bi bi-shield-check"></i>
                                            </div>
                                            <div class="feature-text">
                                                <h6>Secure & Safe</h6>
                                                <p>Verified users</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-12">
                                <div class="image-container">
                                    <div class="floating-shapes">
                                        <div class="shape shape-1"></div>
                                        <div class="shape shape-2"></div>
                                        <div class="shape shape-3"></div>
                                    </div>
                                    <img
                                        src="../../../images/happy.svg"
                                        alt="Happy community illustration"
                                        class="about-image"
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<style scoped>
.about-section {
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    padding: 6rem 0;
    position: relative;
    overflow: hidden;
}

.about-section::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 600px;
    height: 600px;
    background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    opacity: 0.03;
    animation: float 6s ease-in-out infinite;
}

.about-section::after {
    content: '';
    position: absolute;
    bottom: -30%;
    left: -10%;
    width: 400px;
    height: 400px;
    background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
    border-radius: 50%;
    opacity: 0.03;
    animation: float 8s ease-in-out infinite reverse;
}

@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-20px) rotate(180deg); }
}

.about-hero-section {
    position: relative;
    z-index: 2;
}

.badge-container {
    text-align: left;
}

.about-badge {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 0.5rem 1.5rem;
    border-radius: 50px;
    font-size: 0.875rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.hero-title {
    font-size: 3.5rem;
    font-weight: 800;
    line-height: 1.1;
    margin-bottom: 1.5rem;
    background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.gradient-text {
    background: linear-gradient(45deg, #667eea, #764ba2, #f093fb);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    animation: gradient-shift 3s ease-in-out infinite;
}

@keyframes gradient-shift {
    0%, 100% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
}

.hero-subtitle {
    font-size: 1.25rem;
    line-height: 1.7;
    color: #64748b;
    margin-bottom: 2rem;
    font-weight: 400;
}

.image-container {
    position: relative;
    padding: 2rem;
}

.about-image {
    width: 100%;
    height: auto;
    max-width: 500px;
    filter: drop-shadow(0 20px 40px rgba(0, 0, 0, 0.1));
    transform: perspective(1000px) rotateY(-5deg) rotateX(5deg);
    transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    border-radius: 20px;
}

.about-image:hover {
    transform: perspective(1000px) rotateY(0deg) rotateX(0deg) scale(1.05);
    filter: drop-shadow(0 25px 50px rgba(0, 0, 0, 0.15));
}

.floating-shapes {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
}

.shape {
    position: absolute;
    border-radius: 50%;
    background: linear-gradient(45deg, #667eea, #764ba2);
    opacity: 0.1;
    animation: float-shapes 6s ease-in-out infinite;
}

.shape-1 {
    width: 80px;
    height: 80px;
    top: 10%;
    right: 10%;
    animation-delay: 0s;
}

.shape-2 {
    width: 60px;
    height: 60px;
    bottom: 20%;
    left: 5%;
    animation-delay: 2s;
}

.shape-3 {
    width: 40px;
    height: 40px;
    top: 50%;
    right: 20%;
    animation-delay: 4s;
}

@keyframes float-shapes {
    0%, 100% { transform: translateY(0px) scale(1); }
    50% { transform: translateY(-20px) scale(1.1); }
}

.feature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

.feature-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem;
    border-radius: 12px;
    background: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;
}

.feature-item:hover {
    transform: translateY(-5px);
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.feature-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    background: linear-gradient(45deg, #667eea, #764ba2);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.25rem;
}

.feature-text h6 {
    margin: 0;
    font-weight: 600;
    color: #2d3748;
}

.feature-text p {
    margin: 0;
    font-size: 0.875rem;
    color: #64748b;
}

/* Responsive Design */
@media (max-width: 1200px) {
    .hero-title {
        font-size: 3rem;
    }
}

@media (max-width: 992px) {
    .about-section {
        padding: 4rem 0;
    }
    
    .hero-title {
        font-size: 2.5rem;
    }
    
    .image-container {
        margin-top: 3rem;
        padding: 1rem;
    }
    
    .about-image {
        transform: none;
    }
    
    .about-image:hover {
        transform: scale(1.02);
    }
}

@media (max-width: 768px) {
    .hero-title {
        font-size: 2rem;
    }
    
    .hero-subtitle {
        font-size: 1.125rem;
    }
    
    .feature-grid {
        grid-template-columns: 1fr;
    }
    
    .about-section::before,
    .about-section::after {
        display: none;
    }
}

@media (max-width: 576px) {
    .about-section {
        padding: 3rem 0;
    }
    
    .hero-title {
        font-size: 1.75rem;
    }
    
    .hero-subtitle {
        font-size: 1rem;
    }
    
    .about-badge {
        font-size: 0.75rem;
        padding: 0.4rem 1rem;
    }
}

/* Reduced motion for accessibility */
@media (prefers-reduced-motion: reduce) {
    .about-image,
    .feature-item,
    .shape,
    .gradient-text {
        animation: none;
        transition: none;
    }
    
    .about-image:hover {
        transform: none;
    }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
    .about-section {
        background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
    }
    
    .hero-title {
        background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e0 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .hero-subtitle {
        color: #a0aec0;
    }
    
    .feature-item {
        background: rgba(45, 55, 72, 0.8);
        border: 1px solid rgba(74, 85, 104, 0.3);
    }
    
    .feature-text h6 {
        color: #e2e8f0;
    }
    
    .feature-text p {
        color: #a0aec0;
    }
}
</style>