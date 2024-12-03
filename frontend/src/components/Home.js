import React from 'react';
import { Link } from 'react-router-dom';
import './Home.css'; // Optional: For custom styling

function Home() {
  return (
    <div className="home-container">
      <header className="home-header">
        <h1>Safe. Comfortable. Empowering.</h1>
        <p>
          Ride with confidence. Our platform is designed exclusively for women, by women, ensuring your safety and comfort with every journey.
        </p>
        <div className="home-buttons">
          <Link to="/book" className="button-primary">Book a Ride</Link>
          <Link to="/signup" className="button-secondary">Become a Driver</Link>
        </div>
      </header>

     <section className="features">
  <h2>Why Choose Rahiyaa?</h2>
  <div className="feature-grid">
    <div className="feature-item">
      <i className="icon fa fa-female"></i>
      <h3>Women-Only Drivers</h3>
      <p>All our drivers are carefully vetted women to ensure maximum comfort and safety.</p>
    </div>
    <div className="feature-item">
      <i className="icon fa fa-shield"></i>
      <h3>Advanced Safety Features</h3>
      <p>Real-time tracking, emergency SOS, and verified background checks.</p>
    </div>
    <div className="feature-item">
      <i className="icon fa fa-tags"></i>
      <h3>Transparent Pricing</h3>
      <p>No surge pricing. Fair, upfront rates with no hidden charges.</p>
    </div>
  </div>
</section>

      <footer className="home-footer">
        <p>&copy; 2024 Rahiyaa. All rights reserved.</p>
        <Link to="/privacy">Privacy Policy</Link> | <Link to="/terms">Terms of Service</Link> | <Link to="/contact">Contact Us</Link>
      </footer>
    </div>
  );
}

export default Home;

