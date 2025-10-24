

<script setup>
import {Link} from "@inertiajs/vue3";
</script>
<template>
  <div>
     <footer id="footer" class="footer mt-5 pt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <h5>Contact Info.</h5>
                        <ul class="list-unstyled">
                            <li><p>09098127615</p></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Social media</h5>
                        <ul class="list-unstyled">
                            <li>
                                <a href="https://www.facebook.com/pnpbulan.sorsogon"
                                    >
                                    <!-- <i
                                        class="bi bi-facebook text-light me-2"
                                    ></i
                                    > -->
                                    Facebook</a
                                >
                            </li>
                            <!-- <li>
                                <a href="#"
                                    ><i
                                        class="bi bi-twitter text-light me-2"
                                    ></i
                                    >Twitter</a
                                >
                            </li>
                            <li>
                                <a href="#"
                                    ><i
                                        class="bi bi-instagram text-light me-2"
                                    ></i
                                    >Instagram</a
                                >
                            </li> -->
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="#hero-content">Home</a></li>
                            <!-- <li> <Link :href="route('contactPage')" class="link text-decoration-none">Contact</Link></li> -->
                            <li>
                                <Link :href="route('aboutUs')">About Us</Link>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Lost and Found</h5>
                        <ul class="list-unstyled">
                            <li>
                                <Link :href="route('view.privacy')">Terms & Conditions</Link>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row mt-5">
                    <div class="col-md-4">
                        <h5>Bulan Lost And Found Web App</h5>
                        <div class="social-icons">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
  </div>
</template>



<style scoped>
@import "../../../css/welcome.css";

</style>